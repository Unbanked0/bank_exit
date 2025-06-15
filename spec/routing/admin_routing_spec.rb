require 'rails_helper'

RSpec.describe 'Admin', type: :request do
  describe '/admin' do
    subject! { get('/admin') }

    it { expect(response).to redirect_to admin_dashboard_path }
  end
end
