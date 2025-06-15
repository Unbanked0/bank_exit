require 'rails_helper'

RSpec.describe 'DeliveryZones' do
  describe 'GET /delivery_zones/mode_values.turbo_stream' do
    subject! { get '/delivery_zones/mode_values', params: params, as: :turbo_stream }

    context 'when mode is continent' do
      let(:params) { { mode: :continent, target: 'foo', name: 'bar' } }

      it { expect(response).to have_http_status :ok }
    end

    context 'when mode is region' do
      let(:params) { { mode: :region, target: 'foo', name: 'bar' } }

      it { expect(response).to have_http_status :ok }
    end

    context 'when mode is department' do
      let(:params) { { mode: :department, target: 'foo', name: 'bar' } }

      it { expect(response).to have_http_status :ok }
    end
  end
end
