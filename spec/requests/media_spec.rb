require 'rails_helper'

RSpec.describe 'Media' do
  describe 'GET /media' do
    subject! { get '/media' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /en/media' do
    subject! { get '/en/media' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /fr/medias' do
    subject! { get '/fr/medias' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /es/medios' do
    subject! { get '/es/medios' }

    it { expect(response).to have_http_status :ok }
  end
end
