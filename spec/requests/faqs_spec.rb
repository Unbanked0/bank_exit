require 'rails_helper'

RSpec.describe 'FAQs' do
  describe 'GET /en/frequently-asked-questions' do
    subject! { get '/en/frequently-asked-questions' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /fr/foire-aux-questions' do
    subject! { get '/fr/foire-aux-questions' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /es/preguntas-mas-frecuentes' do
    subject! { get '/es/preguntas-mas-frecuentes' }

    it { expect(response).to have_http_status :ok }
  end
end
