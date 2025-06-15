require 'rails_helper'

RSpec.describe 'Welcome' do
  before do
    create_list :merchant, 3
    create_list :directory, 3
  end

  describe 'GET /' do
    subject! { get '/' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /en' do
    subject! { get '/en' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /fr' do
    subject! { get '/fr' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /es' do
    subject! { get '/es' }

    it { expect(response).to have_http_status :ok }
  end
end
