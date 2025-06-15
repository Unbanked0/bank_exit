require 'rails_helper'

RSpec.describe 'Risks' do
  describe 'GET /risks' do
    subject! { get '/risks' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /en/risks' do
    subject! { get '/en/risks' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /risques' do
    subject! { get '/fr/risques' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /es/riesgos' do
    subject! { get '/es/riesgos' }

    it { expect(response).to have_http_status :ok }
  end
end
