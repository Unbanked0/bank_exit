require 'rails_helper'

RSpec.describe 'Merchants::Comments' do
  let(:merchant) { create :merchant }

  describe 'GET /en/merchants/:merchant_id/comments/new' do
    subject! { get "/en/merchants/#{merchant.identifier}/comments/new", as: :turbo_stream }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /fr/commercants/:merchant_id/comments/new' do
    subject! { get "/fr/commercants/#{merchant.identifier}/comments/new", as: :turbo_stream }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /es/comerciantes/:merchant_id/comments/new' do
    subject! { get "/es/comerciantes/#{merchant.identifier}/comments/new", as: :turbo_stream }

    it { expect(response).to have_http_status :ok }
  end

  describe 'POST /en/merchants/:merchant_id/comments' do
    subject(:action) do
      post "/en/merchants/#{merchant.identifier}/comments",
           params: params, as: :turbo_stream
    end

    context 'when params are valid' do
      let(:params) do
        { comment: { content: 'Foobar', rating: 4, affidavit: '1' } }
      end

      describe '[HTTP status]' do
        before { action }

        it { expect(response).to have_http_status :ok }
        it { expect(flash[:notice]).to eq I18n.t('merchants.comments.create.notice') }
      end

      it { expect { action }.to change { Comment.count }.by(1) }
    end

    context 'when acceptance is not checked' do
      let(:params) do
        { comment: { content: 'Foobar', rating: 4 } }
      end

      describe '[HTTP status]' do
        before { action }

        it { expect(response).to have_http_status :unprocessable_entity }
      end

      it { expect { action }.to_not change { Comment.count } }
    end

    context 'when acceptance is filled with random value' do
      let(:params) do
        { comment: { content: 'Foobar', rating: 4, affidavit: 'fake' } }
      end

      describe '[HTTP status]' do
        before { action }

        it { expect(response).to have_http_status :ok }
      end

      it { expect { action }.to change { Comment.count }.by(1) }
    end

    context 'when params are invalid' do
      let(:params) {  { comment: { content: '', affidavit: '1' } } }

      describe '[HTTP status]' do
        before { action }

        it { expect(response).to have_http_status :unprocessable_entity }
      end

      it { expect { action }.to_not change { Comment.count } }
    end

    context 'when captcha is filled' do
      let(:params) do
        { comment: { content: 'Foobar', rating: 4, nickname: 'bot', affidavit: '1' } }
      end

      describe '[HTTP status]' do
        before { action }

        it { expect(response).to have_http_status :ok }
        it { expect(flash[:notice]).to eq I18n.t('merchants.comments.create.notice') }
      end

      it { expect { action }.to_not change { Comment.count } }
    end
  end
end
