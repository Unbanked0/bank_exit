require 'rails_helper'

RSpec.describe 'Contacts' do
  let(:contact_id) { 'Session' }
  let(:invalid_contact_id) { 'fakeID' }

  I18n.available_locales.each do |locale|
    describe "GET /#{locale}/contacts/:id" do
      context 'when :session' do
        subject! { get "/#{locale}/contacts/Session" }

        it { expect(response).to have_http_status :ok }
      end

      context 'when :nostr' do
        subject! { get "/#{locale}/contacts/Nostr" }

        it { expect(response).to have_http_status :ok }
      end

      context 'when :email' do
        subject! { get "/#{locale}/contacts/Email" }

        it { expect(response).to have_http_status :ok }
      end

      context 'when contact does not exist' do
        subject! { get "/#{locale}/contacts/#{invalid_contact_id}" }

        it { expect(response).to have_http_status :not_found }
      end
    end
  end
end
