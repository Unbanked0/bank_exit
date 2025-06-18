require 'rails_helper'

RSpec.describe 'Maps::Referers' do
  describe 'PATCH /maps/referer' do
    subject! { patch '/maps/referer' }

    it { expect(response).to have_http_status :ok }
  end
end
