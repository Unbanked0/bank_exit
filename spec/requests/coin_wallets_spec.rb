require 'rails_helper'

RSpec.describe 'CoinWallets' do
  I18n.available_locales.each do |locale|
    describe "GET /#{locale}/coin_wallets/:id.turbo_stream" do
      subject! { get "/#{locale}/coin_wallets/#{coin.id}", as: :turbo_stream }

      context 'when coin is disabled' do
        let(:coin) { create :coin_wallet, enabled: false }

        it { expect(response).to have_http_status :not_found }
      end

      context 'when coin is bitcoin' do
        let(:coin) { create :coin_wallet, coin: :bitcoin }

        it { expect(response).to have_http_status :ok }
      end

      context 'when coin is monero' do
        let(:coin) { create :coin_wallet, coin: :monero }

        it { expect(response).to have_http_status :ok }
      end

      context 'when coin is june' do
        let(:coin) { create :coin_wallet, coin: :june }

        it { expect(response).to have_http_status :ok }
      end

      context 'when coin is lightning' do
        let(:coin) { create :coin_wallet, coin: :lightning }

        it { expect(response).to have_http_status :ok }
      end
    end
  end
end
