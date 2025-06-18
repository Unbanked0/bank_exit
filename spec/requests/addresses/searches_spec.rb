require 'rails_helper'

RSpec.describe 'Addresses::Searches' do
  describe 'GET /addresses/search' do
    subject! { get '/addresses/search', as: :json }

    it { expect(response).to have_http_status :ok }
  end
end
