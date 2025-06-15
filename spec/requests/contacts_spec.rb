require 'rails_helper'

RSpec.describe 'Contacts' do
  let(:contact_id) { 'Session' }
  let(:invalid_contact_id) { 'fakeID' }

  describe 'GET /contacts/:id' do
    context 'when :session' do
      subject! { get '/contacts/Session' }

      it { expect(response).to have_http_status :ok }
    end

    context 'when :nostr' do
      subject! { get '/contacts/Nostr' }

      it { expect(response).to have_http_status :ok }
    end

    context 'when :email' do
      subject! { get '/contacts/Email' }

      it { expect(response).to have_http_status :ok }
    end

    context 'when contact does not exist' do
      subject! { get "/contacts/#{invalid_contact_id}" }

      it { expect(response).to have_http_status :not_found }
    end
  end

  describe 'GET /en/contacts/:id' do
    context 'when :session' do
      subject! { get '/en/contacts/Session' }

      it { expect(response).to have_http_status :ok }
    end

    context 'when :nostr' do
      subject! { get '/en/contacts/Nostr' }

      it { expect(response).to have_http_status :ok }
    end

    context 'when :email' do
      subject! { get '/en/contacts/Email' }

      it { expect(response).to have_http_status :ok }
    end

    context 'when contact does not exist' do
      subject! { get "/en/contacts/#{invalid_contact_id}" }

      it { expect(response).to have_http_status :not_found }
    end
  end

  describe 'GET /fr/contacts/:id' do
    context 'when :session' do
      subject! { get '/fr/contacts/Session' }

      it { expect(response).to have_http_status :ok }
    end

    context 'when :nostr' do
      subject! { get '/fr/contacts/Nostr' }

      it { expect(response).to have_http_status :ok }
    end

    context 'when :email' do
      subject! { get '/fr/contacts/Email' }

      it { expect(response).to have_http_status :ok }
    end

    context 'when contact does not exist' do
      subject! { get "/fr/contacts/#{invalid_contact_id}" }

      it { expect(response).to have_http_status :not_found }
    end
  end

  describe 'GET /es/contactos/:id' do
    context 'when :session' do
      subject! { get '/es/contactos/Session' }

      it { expect(response).to have_http_status :ok }
    end

    context 'when :nostr' do
      subject! { get '/es/contactos/Nostr' }

      it { expect(response).to have_http_status :ok }
    end

    context 'when :email' do
      subject! { get '/es/contactos/Email' }

      it { expect(response).to have_http_status :ok }
    end

    context 'when contact does not exist' do
      subject! { get "/es/contactos/#{invalid_contact_id}" }

      it { expect(response).to have_http_status :not_found }
    end
  end
end
