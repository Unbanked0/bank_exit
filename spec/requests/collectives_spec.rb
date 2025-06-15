require 'rails_helper'

RSpec.describe 'Collectives' do
  describe 'GET /collective' do
    subject! { get '/collective' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /en/collective' do
    subject! { get '/en/collective' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /fr/le-collectif' do
    subject! { get '/fr/le-collectif' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /es/el-colectivo' do
    subject! { get '/es/el-colectivo' }

    it { expect(response).to have_http_status :ok }
  end
end
