require 'rails_helper'

RSpec.describe 'FAQs' do
  describe 'GET /local_groups' do
    subject! { get '/local_groups' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /en/local-groups' do
    subject! { get '/en/local-groups' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /fr/groupes-locaux' do
    subject! { get '/fr/groupes-locaux' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /es/grupos-locales' do
    subject! { get '/es/grupos-locales' }

    it { expect(response).to have_http_status :ok }
  end
end
