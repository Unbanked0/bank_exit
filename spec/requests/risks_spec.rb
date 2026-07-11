require 'rails_helper'

RSpec.describe 'Risks' do
  describe 'GET /risks' do
    subject! { get '/risks' }

    it { expect(response).to have_http_status :redirect }
  end

  TEST_LOCALES.each do |locale|
    describe "GET /#{locale}/risks" do
      subject! { get "/#{locale}/risks" }

      it { expect(response).to have_http_status :ok }
    end
  end
end
