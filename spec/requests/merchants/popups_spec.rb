require 'rails_helper'

RSpec.describe 'Merchants::Popups' do
  let(:merchant) { create :merchant }
  let(:invalid_merchant_id) { 'fakeID' }

  describe 'GET /merchants/:id' do
    subject! { get "/merchants/#{merchant.identifier}/popup" }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /en/merchants/:id' do
    subject! { get "/en/merchants/#{merchant.identifier}/popup" }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /fr/commercants/:id/popup' do
    context 'when merchant exists' do
      subject! { get "/fr/commercants/#{merchant.identifier}/popup" }

      it { expect(response).to have_http_status :ok }
    end

    context 'when merchant does not exist' do
      subject! { get "/fr/commercants/#{invalid_merchant_id}/popup" }

      it { expect(response).to have_http_status :not_found }
    end
  end

  describe 'GET /es/comerciantes/:id' do
    subject! { get "/es/comerciantes/#{merchant.identifier}/popup" }

    it { expect(response).to have_http_status :ok }
  end
end
