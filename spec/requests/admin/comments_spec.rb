require 'rails_helper'

RSpec.describe 'Admin::Comments' do
  describe 'GET /admin/comments' do
    subject(:action) { get path, headers: headers }

    let(:method) { :get }
    let(:path) { '/admin/comments' }
    let(:headers) { basic_auth_headers }

    context 'when credentials are valid' do
      before do
        create_list :comment, 3
        create :comment, :flagged

        action
      end

      it { expect(response).to have_http_status :ok }
    end

    it_behaves_like 'an authenticated endpoint'
  end

  describe 'PATCH /admin/comments/:id' do
    subject(:action) { patch path, headers: headers }

    let(:comment) { create :comment, :flagged }
    let(:method) { :patch }
    let(:path) { "/admin/comments/#{comment.id}" }
    let(:headers) { basic_auth_headers }

    context 'when credentials are valid' do
      before { action }

      it { expect(comment.reload.flag_reason).to be_nil }
      it { expect(response).to redirect_to admin_comments_path }
      it { expect(flash[:notice]).to eq('Le commentaire a bien été réactivé') }
    end

    it_behaves_like 'an authenticated endpoint'
  end

  describe 'DELETE /admin/comments/:id' do
    subject(:action) { delete path, headers: headers }

    let!(:comment) { create :comment, :flagged }
    let(:method) { :delete }
    let(:path) { "/admin/comments/#{comment.id}" }
    let(:headers) { basic_auth_headers }

    context 'when credentials are valid' do
      it { expect { action }.to change { Comment.count }.by(-1) }

      describe '[HTTP status]' do
        before { action }

        it { expect(response).to redirect_to admin_comments_path }
        it { expect(flash[:notice]).to eq('Le commentaire a bien été supprimé') }
      end
    end

    it_behaves_like 'an authenticated endpoint'
  end
end
