require 'rails_helper'

RSpec.describe 'Maps::Embeds' do
  describe 'GET /en/map/embed' do
    subject! { get '/en/map/embed' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /fr/map/embed' do
    subject! { get '/fr/map/embed' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /es/map/embed' do
    subject! { get '/es/map/embed' }

    it { expect(response).to have_http_status :ok }
  end
end
