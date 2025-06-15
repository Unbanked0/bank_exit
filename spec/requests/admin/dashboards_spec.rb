require 'rails_helper'

RSpec.describe 'Admin::Dashboards' do
  describe 'GET /admin/dashboard' do
    subject(:action) { get path, headers: headers }

    let(:method) { :get }
    let(:path) { '/admin/dashboard' }
    let(:headers) { basic_auth_headers }

    context 'when credentials are valid' do
      before do
        create_list :merchant, 4, bitcoin: true, monero: true
        create :merchant, country: 'FR', category: 'restaurant'
        create :merchant, country: 'FR', june: true

        action
      end

      it { expect(response).to have_http_status :ok }
    end

    it_behaves_like 'an authenticated endpoint'
  end
end
