require 'rails_helper'

RSpec.describe 'Admin::Merchants::DirectoryConverters' do
  describe 'POST /admin/merchants/:id/directory_converters' do
    subject(:action) { post path, headers: headers }

    let!(:merchant) do
      create :merchant, name: 'John Doe',
                        description: 'Lorem Ipsum',
                        full_address: 'Paris',
                        coins: [:bitcoin],
                        contact_twitter: 'https://x.com/johnDoe'
    end

    let(:method) { :post }
    let(:path) { "/admin/merchants/#{merchant.identifier}/directory_converters" }
    let(:headers) { basic_auth_headers }

    before do
      stub_geocoder_from_fixture!
    end

    context 'when credentials are valid' do
      let(:directory) { Directory.last }

      it { expect { action }.to change { Directory.count }.by(1) }

      context 'when directory has already been created' do
        before do
          create :directory, merchant: merchant
        end

        it { expect { action }.to_not change { Directory.count } }
      end

      context 'when directory does not yet exist' do
        before { action }

        it 'has correct regular attributes', :aggregate_failures do
          expect(directory.name).to eq 'John Doe'
          expect(directory.description).to eq 'Lorem Ipsum'
          expect(directory.category).to be_nil
          expect(directory.enabled).to be false
        end

        it { expect(directory.address.label).to eq 'Paris' }

        it 'has correct :contact_ways attributes', :aggregate_failures do
          expect(directory.contact_ways.count).to eq 1
          expect(directory.contact_ways.first.value).to eq 'https://x.com/johnDoe'
        end

        it 'has correct :coin_wallets attributes', :aggregate_failures do
          expect(directory.coin_wallets.count).to eq 1
          expect(directory.coin_wallets.first.coin).to eq 'bitcoin'
          expect(directory.coin_wallets.first.public_address).to be_nil
        end

        it { expect(directory.delivery_zones.count).to eq 0 }
      end

      describe '[HTTP status]' do
        before { action }

        it { expect(response).to redirect_to edit_admin_directory_path(directory) }
        it { expect(flash[:notice]).to eq("L'entrée de l'annuaire a bien été créée. Pensez à la réactiver une fois les modifications effectuées") }
      end
    end

    it_behaves_like 'an authenticated endpoint'
  end
end
