require 'rails_helper'

RSpec.describe NostrPublisher do
  let(:identifier) { 'foobar-123' }
  let(:merchant_sync) { create :merchant_sync }
  let(:relays) { [] }

  before { enable_feature :nostr }

  describe '#call' do
    subject(:call) do
      described_class.call(
        merchant_sync,
        identifier: identifier,
        relays: relays
      )
    end

    let(:client) { instance_double(Nostr::Client) }
    let(:published_event) { Struct.new(:event).new }

    before do
      allow(Nostr::Client).to receive(:new) { client }
      allow(client).to receive(:public_key).and_return('fake_pubkey')
      allow(client).to receive(:connect)
      allow(client).to receive(:close)
      allow(client).to receive(:sign) { |event| event }
      allow(client).to receive(:publish_and_wait) do |event|
        published_event.event = event
        ParsedData.new(
          type: 'OK',
          event_id: '1234567890',
          success: true,
          message: ''
        )
      end
    end

    context 'when private key is missing' do
      before do
        stub_env('NOSTR_PRIVATE_KEY', nil)
      end

      it { expect { call }.to raise_error(NostrErrors::MissingPrivateKey) }
    end

    context 'when relays are not configured' do
      before do
        stub_env('NOSTR_RELAYS_URLS', nil)
      end

      context 'when no relays are provided' do
        it { expect { call }.to raise_error(NostrErrors::MissingRelayUrl) }
      end

      context 'when manual relays are provided' do
        let(:relays) { ['wss://foobar.test', 'wss://lorem.ipsum'] }
        let(:merchant_sync) do
          create :merchant_sync,
                 added_merchants_count: 1,
                 payload_added_merchants: [
                   { 'id' => 'node/123' }
                 ],
                 started_at: Time.current
        end

        before do
          create :merchant, :bitcoin, original_identifier: 'node/123', name: 'Bitcoin Coffee'
        end

        it { expect { call }.not_to raise_error }

        it 'calls Nostr::Event with correct relay', :aggregate_failures do
          call

          expect(Nostr::Client).to have_received(:new)
            .with(
              private_key: instance_of(String),
              relay: 'wss://foobar.test'
            )

          expect(Nostr::Client).to have_received(:new)
            .with(
              private_key: instance_of(String),
              relay: 'wss://lorem.ipsum'
            )
        end
      end
    end

    context 'when new merchant count is positive' do
      let(:merchant_sync) do
        create :merchant_sync,
               added_merchants_count: 3,
               payload_added_merchants: [
                 { 'id' => 'node/123' },
                 { 'id' => 'node/456' },
                 { 'id' => 'way/789' }
               ],
               started_at: Time.current
      end

      let!(:bitcoin_bakery) do
        create :merchant, :bitcoin, original_identifier: 'node/123', name: 'Bitcoin Coffee', category: 'bakery'
      end

      before do
        create :merchant, :bitcoin, original_identifier: 'node/456', name: 'MM salon de thé, pâtisserie, chocolaterie'
        create :merchant, :bitcoin, original_identifier: 'way/789', name: 'Feel SO light'
        create :merchant, :deleted, original_identifier: 'node/111', name: 'Deleted merchant'

        travel_to Time.zone.local(2025, 11, 20, 16, 30, 0)
      end

      context 'when relays hangs with a timeout' do
        before do
          allow(client).to receive(:publish_and_wait).and_raise(StandardError, 'Relay timeout')
        end

        it { expect { call }.to raise_error(NostrErrors::PublicationError) }
      end

      context 'when relays does not hang' do
        before { call }

        it 'calls Nostr::Event with correct relay' do
          expect(Nostr::Client).to have_received(:new)
            .with(
              private_key: instance_of(String),
              relay: 'wss://demo.test'
            )
        end

        it 'connects to relay', :aggregate_failures do
          expect(client).to have_received(:connect)
          expect(client).to have_received(:publish_and_wait).with(instance_of(Nostr::Event), close_on_finish: true)
        end

        it 'has correct tags' do
          tags = published_event.event.tags

          expect(tags).to match_nostr_tags(
            d: 'foobar-123',
            title: 'New Bank-Exit merchants (2025-11-20 at 16:30)',
            summary: 'A list of merchants that accept Bitcoin, Monero, or June, mapped on the bank-exit.org website during the latest synchronization.',
            t: %w[Bank-Exit SortieDeBanque XBT Bitcoin],
            p: 'mynostrpubkey',
            published_at: Time.current.to_i.to_s
          )
        end

        it 'has correct content', :aggregate_failures do
          content = published_event.event.content

          expect(content).to include('Discover **3** newly listed Bitcoin (₿) merchants now featured on the ')
          expect(content).to include("**[Bitcoin Coffee](http://example.test/en/merchants/#{bitcoin_bakery.identifier}-bitcoin-coffee)** (Bakery) ₿ Bitcoin")
          expect(content).to include('MM salon de thé, pâtisserie, chocolaterie')
          expect(content).to include('Feel SO light')
          expect(content).to match(/_Merchants are based on free and open data from OpenStreetMap. Information may change over time and could differ from what is shown here, with some links potentially no longer existing._/)
          expect(content).not_to include('Deleted merchant')
        end

        it 'has correct response payload', :aggregate_failures do
          nostr_event = merchant_sync.nostr_event

          expect(nostr_event.event_identifier).to eq '1234567890'
          expect(nostr_event.payload_event).to eq published_event.event.as_json
          expect(nostr_event.payload_response).to eq({
            data: {
              type: 'OK',
              event_id: '1234567890',
              success: true,
              message: ''
            }
          }.as_json)
        end
      end
    end

    describe '[coins tags]' do
      let(:merchant_sync) do
        create :merchant_sync,
               added_merchants_count: 1,
               payload_added_merchants: [
                 { 'id' => 'node/123' }
               ]
      end
      let(:tags) { published_event.event.tags }
      let(:content) { published_event.event.content }

      context 'when merchant is Bitcoin' do
        before do
          create :merchant, :bitcoin,
                 original_identifier: 'node/123'
          call
        end

        it { expect(tags).to match_nostr_tags(t: %w[Bank-Exit SortieDeBanque XBT Bitcoin]) }
        it { expect(content).to include('Discover **1** newly listed Bitcoin (₿) merchant now featured on the ') }
      end

      context 'when merchant is Bitcoin LN' do
        before do
          create :merchant, :lightning,
                 original_identifier: 'node/123'
          call
        end

        it { expect(tags).to match_nostr_tags(t: %w[Bank-Exit SortieDeBanque XBT Bitcoin LightningNetwork]) }
        it { expect(content).to include('Discover **1** newly listed Bitcoin Lightning (⚡) merchant now featured on the ') }
      end

      context 'when merchant is Bitcoin LN contactless' do
        before do
          create :merchant, :lightning_contactless,
                 original_identifier: 'node/123'
          call
        end

        it { expect(tags).to match_nostr_tags(t: %w[Bank-Exit SortieDeBanque XBT Bitcoin LightningNetwork]) }
        it { expect(content).to include('Discover **1** newly listed Bitcoin Lightning (⚡) merchant now featured on the ') }
      end

      context 'when merchant is Monero' do
        before do
          create :merchant, :monero,
                 original_identifier: 'node/123'
          call
        end

        it { expect(tags).to match_nostr_tags(t: %w[Bank-Exit SortieDeBanque XMR Monero]) }
        it { expect(content).to include('Discover **1** newly listed Monero (🔒) merchant now featured on the ') }
      end

      context 'when merchant is June' do
        before do
          create :merchant, :june,
                 original_identifier: 'node/123'
          call
        end

        it { expect(tags).to match_nostr_tags(t: %w[Bank-Exit SortieDeBanque XG1 June]) }
        it { expect(content).to include('Discover **1** newly listed June (🟡) merchant now featured on the ') }
      end

      context 'when merchants have multiple coins' do
        before do
          create :merchant, :monero, :june,
                 original_identifier: 'node/123'
          call
        end

        it { expect(tags).to match_nostr_tags(t: %w[Bank-Exit SortieDeBanque XMR Monero XG1 June]) }
        it { expect(content).to include('Discover **1** newly listed Monero (🔒), June (🟡) merchant now featured on the ') }
      end

      context 'when merchants category is unknown' do
        before do
          create :merchant, :monero, :june,
                 category: 'yes',
                 original_identifier: 'node/123'
          call
        end

        it { expect(content).not_to match(/(Unknown Category)/) }
      end
    end

    context 'when new merchant count is null' do
      let(:merchant_sync) do
        create :merchant_sync, added_merchants_count: 0
      end

      before { call }

      it 'does not connect to relay', :aggregate_failures do
        expect(client).not_to have_received(:connect)
        expect(client).not_to have_received(:publish_and_wait)
        expect(client).not_to have_received(:close)
      end
    end

    context 'when geocoding fails to assign merchants country' do
      let(:merchant_sync) do
        create :merchant_sync,
               added_merchants_count: 1,
               payload_added_merchants: [
                 { 'id' => 'node/123' }
               ],
               started_at: Time.current
      end

      before do
        create :merchant, :bitcoin, original_identifier: 'node/123', name: 'Bitcoin Coffee', country: nil
        call
      end

      it 'does not connect to relay', :aggregate_failures do
        expect(client).not_to have_received(:connect)
        expect(client).not_to have_received(:publish_and_wait)
        expect(client).not_to have_received(:close)
      end
    end

    context 'when merchant category is nil' do
      let(:merchant_sync) do
        create :merchant_sync,
               added_merchants_count: 1,
               payload_added_merchants: [
                 { 'id' => 'node/123' }
               ],
               started_at: Time.current
      end

      before do
        create :merchant, :bitcoin, original_identifier: 'node/123', name: 'Bitcoin Coffee', category: nil
        call
      end

      it 'has correct content' do
        content = published_event.event.content

        expect(content).to include('Bitcoin Coffee')
      end
    end
  end
end
