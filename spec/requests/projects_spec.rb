require 'rails_helper'

def project_ids
  %w[grocery cheque sticker]
end

RSpec.describe 'Projects' do
  let(:invalid_project_id) { 'fake' }

  describe 'GET /projects/:id' do
    project_ids.each do |project_id|
      context "when #{project_id} project" do
        subject! { get "/projects/#{project_id}" }

        it { expect(response).to have_http_status :ok }
      end
    end

    context 'when flyer project' do
      subject! { get '/projects/flyer' }

      it { expect(response).to redirect_to blog_en_path('flyer') }
    end

    context 'when project does not exist' do
      subject! { get "/projects/#{invalid_project_id}" }

      it { expect(response).to have_http_status :not_found }
    end
  end

  describe 'GET /en/projects/:id' do
    project_ids.each do |project_id|
      context "when #{project_id} project" do
        subject! { get "/en/projects/#{project_id}" }

        it { expect(response).to have_http_status :ok }
      end
    end

    context 'when flyer project' do
      subject! { get '/en/projects/flyer' }

      it { expect(response).to redirect_to blog_en_path('flyer') }
    end

    context 'when project does not exist' do
      subject! { get "/en/projects/#{invalid_project_id}" }

      it { expect(response).to have_http_status :not_found }
    end
  end

  describe 'GET /fr/projets/:id' do
    project_ids.each do |project_id|
      context "when #{project_id} project" do
        subject! { get "/fr/projets/#{project_id}" }

        it { expect(response).to have_http_status :ok }
      end
    end

    context 'when flyer project' do
      subject! { get '/fr/projets/flyer' }

      it { expect(response).to redirect_to blog_fr_path('flyer') }
    end

    context 'when project does not exist' do
      subject! { get "/fr/projets/#{invalid_project_id}" }

      it { expect(response).to have_http_status :not_found }
    end
  end

  describe 'GET /es/proyectos/:id' do
    project_ids.each do |project_id|
      context "when #{project_id} project" do
        subject! { get "/es/proyectos/#{project_id}" }

        it { expect(response).to have_http_status :ok }
      end
    end

    context 'when flyer project' do
      subject! { get '/es/proyectos/flyer' }

      it { expect(response).to redirect_to blog_es_path('flyer') }
    end

    context 'when project does not exist' do
      subject! { get "/es/proyectos/#{invalid_project_id}" }

      it { expect(response).to have_http_status :not_found }
    end
  end
end
