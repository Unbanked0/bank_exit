require 'rails_helper'

def blog_ids
  %w[flyer presentation-bank-exit cbdc-digital-euro]
end

RSpec.describe 'Blogs' do
  let(:invalid_blog_id) { 'fake' }

  describe 'GET /en/blogs' do
    subject! { get '/en/blogs/' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /fr/blogs' do
    subject! { get '/fr/blogs/' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /es/blogs' do
    subject! { get '/es/blogs/' }

    it { expect(response).to have_http_status :ok }
  end

  describe 'GET /en/blogs/:id' do
    blog_ids.each do |blog_id|
      context "when #{blog_id} blog" do
        subject! { get "/en/blogs/#{blog_id}" }

        it { expect(response).to have_http_status :ok }
      end
    end

    context 'when blog does not exist' do
      subject! { get "/en/blogs/#{invalid_blog_id}" }

      it { expect(response).to have_http_status :not_found }
    end
  end

  describe 'GET /fr/blogs/:id' do
    blog_ids.each do |blog_id|
      context "when #{blog_id} blog" do
        subject! { get "/fr/blogs/#{blog_id}" }

        it { expect(response).to have_http_status :ok }
      end
    end

    context 'when blog does not exist' do
      subject! { get "/fr/blogs/#{invalid_blog_id}" }

      it { expect(response).to have_http_status :not_found }
    end
  end

  describe 'GET /es/blogs/:id' do
    blog_ids.each do |blog_id|
      context "when #{blog_id} blog" do
        subject! { get "/es/blogs/#{blog_id}" }

        it { expect(response).to have_http_status :ok }
      end
    end

    context 'when blog does not exist' do
      subject! { get "/es/blogs/#{invalid_blog_id}" }

      it { expect(response).to have_http_status :not_found }
    end
  end
end
