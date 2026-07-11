require 'rails_helper'

RSpec.describe 'Maps::Embeds' do
  TEST_LOCALES.each do |locale|
    describe "GET /#{locale}/map/embed" do
      subject! { get "/#{locale}/map/embed" }

      it { expect(response).to have_http_status :ok }
    end
  end
end
