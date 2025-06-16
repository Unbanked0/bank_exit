require 'rails_helper'

RSpec.describe 'Merchants::Itineraries' do
  let(:merchant) { create :merchant, :with_geometry_point }

  describe 'GET /en/merchants/:id/itinerary/new' do
    subject! { get "/en/merchants/#{merchant.identifier}/itinerary/new" }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /fr/commercants/:id/itinerary/new' do
    subject! { get "/fr/commercants/#{merchant.identifier}/itinerary/new" }

    it { expect(response).to have_http_status :ok }
  end

  describe 'POST /fr/commercants/:id/itinerary' do
    subject(:action) do
      post "/fr/commercants/#{merchant.identifier}/itinerary",
           params: params, as: :turbo_stream
    end

    before do
      stub_geocoder_from_fixture!
    end

    context 'when using IP location' do
      let(:params) { { itinerary: { use_my_ip: '1' } } }

      before do
        stub_osrm_success
        action
      end

      it { expect(response).to have_http_status :ok }
    end

    context 'when using input address location' do
      let(:params) { { itinerary: { my_address: 'Paris' } } }

      before do
        stub_osrm_success
        action
      end

      it { expect(response).to have_http_status :ok }
    end

    context 'when an error occured' do
      let(:params) { { itinerary: { use_my_ip: '1' } } }

      before do
        stub_osrm_failure
        action
      end

      it { expect(response).to have_http_status :ok }
    end
  end
end
