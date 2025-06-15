require 'rails_helper'

RSpec.describe 'Admin::DirectoriesController' do
  let(:headers) { basic_auth_headers }

  describe 'GET /admin/directories' do
    subject(:action) { get path, headers: headers }

    let(:method) { :get }
    let(:path) { '/admin/directories' }

    before do
      create_list :directory, 2
      action
    end

    it { expect(response).to have_http_status :ok }

    it_behaves_like 'an authenticated endpoint'
  end

  describe 'GET /admin/directories/new' do
    subject(:action) { get path, headers: headers }

    let(:method) { :get }
    let(:path) { '/admin/directories/new' }

    before { action }

    it { expect(response).to have_http_status :ok }

    it_behaves_like 'an authenticated endpoint'
  end

  describe 'POST /admin/directories' do
    subject(:action) { post path, params: params, headers: headers }

    let(:method) { :post }
    let(:path) { '/admin/directories' }

    let(:params) do
      {
        directory: {
          name: 'Nouveau',
          description: 'Desc',
          category: :food,
          address_attributes: { label: 'Paris' }
        }
      }
    end

    before do
      stub_geocoder_from_fixture!
    end

    context 'with valid params' do
      it { expect { action }.to change { Directory.count }.by(1) }

      it 'creates a new Directory', :aggregate_failures do
        action
        expect(response).to redirect_to(admin_directories_path)
        expect(flash[:notice]).to eq("L'entrée a bien été ajoutée à l'annuaire")
      end
    end

    it_behaves_like 'an authenticated endpoint'
  end

  describe 'GET /admin/directories/:id/edit' do
    subject(:action) { get path, headers: headers }

    let(:directory) { create :directory }
    let(:method) { :get }
    let(:path) { "/admin/directories/#{directory.id}/edit" }

    before { action }

    it { expect(response).to have_http_status :ok }

    it_behaves_like 'an authenticated endpoint'
  end

  describe 'PATCH /admin/directories/:id' do
    subject(:action) { patch path, params: params, headers: headers }

    let(:directory) { create :directory }
    let(:method) { :patch }
    let(:path) { "/admin/directories/#{directory.id}" }

    let(:params) do
      {
        directory: {
          name: 'Nom modifié'
        }
      }
    end

    context 'with valid params' do
      before { action }

      it { expect(response).to redirect_to(admin_directories_path) }
      it { expect(flash[:notice]).to eq("L'entrée de l'annuaire a bien été modifiée") }

      it 'updates the directory' do
        expect(directory.reload.name).to eq('Nom modifié')
      end
    end

    it_behaves_like 'an authenticated endpoint'
  end

  describe 'DELETE /admin/directories/:id' do
    subject(:action) { delete path, headers: headers }

    let!(:directory) { create :directory }
    let(:method) { :delete }
    let(:path) { "/admin/directories/#{directory.id}" }

    it 'deletes the directory' do
      expect { action }.to change { Directory.count }.by(-1)
    end

    it 'redirects with success message', :aggregate_failures do
      action
      expect(response).to redirect_to(admin_directories_path)
      expect(flash[:notice]).to eq("L'entrée de l'annuaire a bien été supprimée")
    end

    it_behaves_like 'an authenticated endpoint'
  end

  describe 'PATCH /admin/directories/:id/update_position.tubo_stream' do
    subject(:action) { patch path, params: params, headers: headers, as: :turbo_stream }

    let!(:directory) { create :directory, position: 1 }
    let(:method) { :patch }
    let(:path) { "/admin/directories/#{directory.id}/update_position" }

    let(:params) do
      { directory: { position: 5 } }
    end

    before do
      create_list :directory, 5
    end

    context 'with valid params' do
      before { action }

      it { expect(response).to have_http_status :ok }
      it { expect(directory.reload.position).to eq 5 }
    end

    it_behaves_like 'an authenticated endpoint'
  end
end
