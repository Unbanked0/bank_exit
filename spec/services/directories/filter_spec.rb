require 'rails_helper'

RSpec.describe Directories::Filter do
  describe '#call' do
    subject(:call) { described_class.call(**params, ip: ip) }

    let!(:directory_food) { create :directory, name: 'Food', category: :food, position: 2 }
    let!(:directory_h16) { create :directory, name: 'H16', category: :media, position: 1 }
    let!(:directory_without_delivery_zone) { create :directory, category: :association, name: 'John Doe' }
    let!(:directory_delivery_japan) { create :directory, category: :association, name: 'Japan Here' }

    let(:ip) { '127.0.0.1' } # stubbed to FR

    before do
      stub_geocoder_from_fixture!

      # Paris
      create :delivery_zone, :department_75, deliverable: directory_food

      # Near Paris
      create :delivery_zone, :department_77, deliverable: directory_h16

      create :delivery_zone, :country_japan, deliverable: directory_delivery_japan
    end

    context 'without filters' do
      let(:params) { {} }

      it { is_expected.to eq [directory_h16, directory_food, directory_without_delivery_zone, directory_delivery_japan] }
    end

    context 'with around_me = "1"' do
      let(:params) { { around_me: '1' } }

      context 'when IP is from France' do
        let(:ip) { '127.0.0.1' } # stubbed to FR

        it { is_expected.to contain_exactly(directory_food, directory_h16) }
      end

      context 'when IP is from Japan' do
        let(:ip) { '127.0.0.2' } # stubbed to JP

        it { is_expected.to contain_exactly(directory_delivery_japan) }
      end
    end

    context 'with query param' do
      let(:params) { { query: 'H16' } }

      it { is_expected.to eq [directory_h16] }
    end

    context 'with category param' do
      let(:params) { { category: 'food' } }

      it { is_expected.to eq [directory_food] }
    end

    context 'with coins param' do
      let(:params) { { coins: ['bitcoin'] } }

      before do
        create :coin_wallet,
               walletable: directory_without_delivery_zone,
               coin: 'bitcoin'
      end

      it { is_expected.to eq [directory_without_delivery_zone] }
    end
  end
end
