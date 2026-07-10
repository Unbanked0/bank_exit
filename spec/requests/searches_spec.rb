require 'rails_helper'

RSpec.describe 'Searches' do
  before do
    create :directory, name: 'Monero'
    create :merchant, name: 'Monero'
  end

  I18n.available_locales.each do |locale|
    describe "GET /#{locale}/search" do
      subject(:action) do
        get "/#{locale}/search", params: { query: 'Monero' }
      end

      before { action }

      it { expect(response).to have_http_status :ok }
    end

    describe "GET /#{locale}/search.turbo_stream" do
      subject(:action) do
        get "/#{locale}/search",
            params: { query: 'Monero' },
            as: :turbo_stream
      end

      before { action }

      it { expect(response).to have_http_status :ok }
    end
  end
end
