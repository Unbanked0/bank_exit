require 'rails_helper'

def coin_ids
  @coin_ids ||= Coin.all.map(&:identifier)
end

RSpec.describe 'Coins' do
  let(:invalid_coin_id) { 'shitcoin' }

  describe 'GET /coins/:id' do
    coin_ids.each do |coin|
      context "when #{coin}" do
        subject! { get "/coins/#{coin}" }

        it { expect(response).to have_http_status :ok }
      end
    end

    context 'when coin does not exist' do
      subject! { get "/coins/#{invalid_coin_id}" }

      it { expect(response).to have_http_status :not_found }
    end
  end

  describe 'GET /en/coins/:id' do
    coin_ids.each do |coin|
      context "when #{coin}" do
        subject! { get "/en/coins/#{coin}" }

        it { expect(response).to have_http_status :ok }
      end
    end

    context 'when coin does not exist' do
      subject! { get "/en/coins/#{invalid_coin_id}" }

      it { expect(response).to have_http_status :not_found }
    end
  end

  describe 'GET /fr/coins/:id' do
    coin_ids.each do |coin|
      context "when #{coin}" do
        subject! { get "/fr/coins/#{coin}" }

        it { expect(response).to have_http_status :ok }
      end
    end

    context 'when coin does not exist' do
      subject! { get "/fr/coins/#{invalid_coin_id}" }

      it { expect(response).to have_http_status :not_found }
    end
  end

  describe 'GET /es/coins/:id' do
    coin_ids.each do |coin|
      context "when #{coin}" do
        subject! { get "/es/coins/#{coin}" }

        it { expect(response).to have_http_status :ok }
      end
    end

    context 'when coin does not exist' do
      subject! { get "/es/coins/#{invalid_coin_id}" }

      it { expect(response).to have_http_status :not_found }
    end
  end
end
