require 'rails_helper'

RSpec.describe 'Admin::Merchants::AssignCountries' do
  describe 'POST /admin/merchants/assign_countries' do
    subject(:action) { post '/admin/merchants/assign_countries' }

    %i[super_admin admin].each do |role|
      context "when role is #{role}" do
        include_context 'with user role', role

        it_behaves_like 'access granted with redirection' do
          let(:redirection_url) { admin_merchants_path }
          let(:flash_notice) { I18n.t('admin.merchants.assign_countries.create.notice') }
        end
      end
    end

    %i[publisher moderator].each do |role|
      context "when role is #{role}" do
        include_context 'with user role', role
        it_behaves_like 'access denied'
      end
    end

    context 'when logged out' do
      include_context 'without login'
      it_behaves_like 'access unauthenticated'
    end
  end
end
