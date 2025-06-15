require 'rails_helper'

RSpec.describe 'Merchants' do
  let(:merchant) do
    create :merchant, :with_address, :with_opening_hours, :with_geometry_polygon, :with_all_contacts
  end
  let(:invalid_merchant_id) { 'fakeID' }

  describe 'GET /merchants/:id' do
    context 'when merchant exists' do
      subject(:action) { get "/merchants/#{merchant.identifier}" }

      before do
        create_list :comment, 3, commentable: merchant
        create :comment, :flagged

        action
      end

      it { expect(response).to have_http_status :ok }
    end

    context 'when merchant does not exist' do
      subject! { get "/merchants/#{invalid_merchant_id}" }

      it { expect(response).to have_http_status :moved_permanently }
      it { expect(response).to redirect_to maps_en_path }
    end
  end

  describe 'GET /en/merchants/:id' do
    context 'when merchant exists' do
      subject(:action) { get "/en/merchants/#{merchant.identifier}" }

      before do
        create_list :comment, 3, commentable: merchant
        create :comment, :flagged

        action
      end

      it { expect(response).to have_http_status :ok }
    end

    context 'when merchant does not exist' do
      subject! { get "/en/merchants/#{invalid_merchant_id}" }

      it { expect(response).to have_http_status :moved_permanently }
      it { expect(response).to redirect_to maps_en_path }
    end
  end

  describe 'GET /fr/commercants/:id' do
    context 'when merchant exists' do
      subject(:action) { get "/fr/commercants/#{merchant.identifier}" }

      before do
        create_list :comment, 3, commentable: merchant
        create :comment, :flagged

        action
      end

      it { expect(response).to have_http_status :ok }
    end

    context 'when merchant does not exist' do
      subject! { get "/fr/commercants/#{invalid_merchant_id}" }

      it { expect(response).to have_http_status :moved_permanently }
      it { expect(response).to redirect_to maps_fr_path }
    end
  end

  describe 'GET /es/comerciantes/:id' do
    context 'when merchant exists' do
      subject(:action) { get "/es/comerciantes/#{merchant.identifier}" }

      before do
        create_list :comment, 3, commentable: merchant
        create :comment, :flagged

        action
      end

      it { expect(response).to have_http_status :ok }
    end

    context 'when merchant does not exist' do
      subject! { get "/es/comerciantes/#{invalid_merchant_id}" }

      it { expect(response).to have_http_status :moved_permanently }
      it { expect(response).to redirect_to maps_es_path }
    end
  end

  describe 'GET /merchants/refresh.turbo_stream' do
    subject(:action) { post '/merchants/refresh', as: :turbo_stream }

    before { stub_overpass_request_success }

    it { expect { action }.to have_enqueued_job(CallableJob).with('FetchMerchants') }

    describe '[HTTP status]' do
      before { action }

      it { expect(response).to have_http_status :ok }
      it { expect(flash[:notice]).to eq I18n.t('merchants.refresh.notice') }
    end
  end
end
