require 'rails_helper'

def tutorial_ids
  %w[
    cakewallet-monero crash-course session-messaging
    nostr-social-network bitcoin-nokyc funding-monero
    monero-node-easymonerod documentation-embed-map accounting
    cryptopayment-for-business
  ]
end

RSpec.describe 'Tutorials' do
  let(:invalid_tutorial_id) { 'fake' }

  before { create :merchant, country: 'FR' }

  describe 'GET /tutorials' do
    subject! { get '/tutorials/' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /en/tutorials' do
    subject! { get '/en/tutorials/' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /fr/tutoriels' do
    subject! { get '/fr/tutoriels' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /es/tutoriales' do
    subject! { get '/es/tutoriales/' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /tutorials/:id' do
    tutorial_ids.each do |tutorial_id|
      context "when #{tutorial_id} tutorial" do
        subject! { get "/tutorials/#{tutorial_id}" }

        it { expect(response).to have_http_status :ok }
      end
    end

    context 'when tutorial does not exist' do
      subject! { get "/tutorials/#{invalid_tutorial_id}" }

      it { expect(response).to have_http_status :not_found }
    end
  end

  describe 'GET /en/tutorials/:id' do
    tutorial_ids.each do |tutorial_id|
      context "when #{tutorial_id} tutorial" do
        subject! { get "/en/tutorials/#{tutorial_id}" }

        it { expect(response).to have_http_status :ok }
      end
    end

    context 'when tutorial does not exist' do
      subject! { get "/en/tutorials/#{invalid_tutorial_id}" }

      it { expect(response).to have_http_status :not_found }
    end
  end

  describe 'GET /fr/tutoriels/:id' do
    tutorial_ids.each do |tutorial_id|
      context "when #{tutorial_id} tutorial" do
        subject! { get "/fr/tutoriels/#{tutorial_id}" }

        it { expect(response).to have_http_status :ok }
      end
    end

    context 'when tutorial does not exist' do
      subject! { get "/fr/tutoriels/#{invalid_tutorial_id}" }

      it { expect(response).to have_http_status :not_found }
    end
  end

  describe 'GET /es/tutoriales/:id' do
    tutorial_ids.each do |tutorial_id|
      context "when #{tutorial_id} tutorial" do
        subject! { get "/es/tutoriales/#{tutorial_id}" }

        it { expect(response).to have_http_status :ok }
      end
    end

    context 'when tutorial does not exist' do
      subject! { get "/es/tutoriales/#{invalid_tutorial_id}" }

      it { expect(response).to have_http_status :not_found }
    end
  end
end
