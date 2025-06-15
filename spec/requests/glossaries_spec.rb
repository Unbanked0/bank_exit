require 'rails_helper'

RSpec.describe 'Glossaries' do
  describe 'GET /en/glossary' do
    subject! { get '/en/glossary' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /fr/glossaire' do
    subject! { get '/fr/glossaire' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /es/glosario' do
    subject! { get '/es/glosario' }

    it { expect(response).to have_http_status :ok }
  end
end
