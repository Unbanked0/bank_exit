require 'rails_helper'

RSpec.describe 'rake sitemap:refresh:no_ping', type: :task do
  before do
    SitemapGenerator::Sitemap.verbose = false
  end

  after do
    File.delete('public/sitemap.xml.gz')

    I18n.available_locales.each do |locale|
      File.delete("public/sitemap.#{locale}.xml.gz")
    end
  end

  it { expect { task.invoke }.not_to raise_error }
end
