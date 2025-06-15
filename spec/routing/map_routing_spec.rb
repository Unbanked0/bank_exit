require 'rails_helper'

RSpec.describe 'Map', type: :request do
  describe '/map/:zoom/:lat/:lon' do
    context 'when :zoom is one digit' do
      subject! { get('/map/5/123.456/654.321') }

      it { expect(response).to have_http_status :ok }
    end

    context 'when :zoom is two digits' do
      subject! { get('/map/15/123.456/654.321') }

      it { expect(response).to have_http_status :ok }
    end

    context 'when :lat is negative' do
      subject! { get('/map/17/-123.456/654.321') }

      it { expect(response).to have_http_status :ok }
    end

    context 'when :lat and :lon are negative' do
      subject! { get('/map/17/-123.456/-654.321') }

      it { expect(response).to have_http_status :ok }
    end

    context 'when :lat and :lon are integer' do
      subject! { get('/map/17/-123/-654') }

      it { expect(response).to have_http_status :ok }
    end
  end
end
