require 'rails_helper'

RSpec.describe 'Admin::Merchants::BatchActions' do
  describe 'PATCH /admin/merchants/batch_actions' do
    subject(:action) { patch path, params: params, headers: headers }

    let(:method) { :patch }
    let(:path) { '/admin/merchants/batch_actions' }
    let(:params) { { batch_actions: { directory_ids: Merchant.ids.join(',') } } }
    let(:headers) { basic_auth_headers }

    let!(:merchant) { create :merchant, :deleted }
    let!(:merchant_2) { create :merchant, :deleted }

    before { action }

    it 'validates back merchants', :aggregate_failures do
      expect(merchant.reload.deleted_at).to be_nil
      expect(merchant_2.reload.deleted_at).to be_nil
    end

    it { expect(response).to redirect_to admin_merchants_path(show_deleted: true) }
    it { expect(flash[:notice]).to eq 'Les commerçants ont bien été réactivés' }

    it_behaves_like 'an authenticated endpoint'
  end

  describe 'DELETE /admin/merchants/batch_actions' do
    subject(:action) { delete path, params: params, headers: headers }

    let(:method) { :delete }
    let(:path) { '/admin/merchants/batch_actions' }
    let(:params) { { batch_actions: { directory_ids: Merchant.ids.join(',') } } }
    let(:headers) { basic_auth_headers }

    before do
      create_list :merchant, 2, :deleted
    end

    it { expect { action }.to change { Merchant.count }.by(-2) }

    describe '[HTTP status]' do
      before { action }

      it { expect(response).to redirect_to admin_merchants_path(show_deleted: true) }
      it { expect(flash[:notice]).to eq 'Les commerçants ont bien été supprimés' }
    end

    it_behaves_like 'an authenticated endpoint'
  end
end
