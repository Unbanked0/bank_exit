require 'rails_helper'

RSpec.describe 'DeliveryZones' do
  I18n.available_locales.each do |locale|
    describe "GET /#{locale}/delivery_zones/mode_values.turbo_stream" do
      subject! do
        get "/#{locale}/delivery_zones/mode_values",
            params: params,
            as: :turbo_stream
      end

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
end
