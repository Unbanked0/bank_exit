require 'rails_helper'

RSpec.describe 'Statistics' do
  before do
    create_list :merchant, 3, created_at: Time.current
    create_list :merchant, 2, created_at: 1.day.ago
    create_list :directory, 3
  end

  describe 'GET /en/stats' do
    subject! { get '/en/stats' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /fr/stats' do
    subject! { get '/fr/stats' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /es/stats' do
    subject! { get '/es/stats' }

    it { expect(response).to have_http_status :ok }
  end
end
