require 'rails_helper'

RSpec.describe 'Licenses' do
  describe 'GET /license' do
    subject! { get '/license' }

    it { expect(response).to have_http_status :ok }
  end
end
