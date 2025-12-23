class PublicController < ApplicationController
  include Localizable
  include Analyticable
  include Themable

  before_action :set_projects
  before_action :set_contacts

  private

  def set_projects
    @projects = Project.all(decorate: true)
  end

  def set_contacts
    @contacts = Contact.all
  end

  # Remove empty GET params from URL
  def clean_url(url)
    uri = URI.parse(url)
    query = Rack::Utils.parse_nested_query(uri.query).compact_blank
    uri.query = query.to_query.presence
    uri.to_s
  end

  def country_for_locale
    return 'GB' if I18n.locale == :en

    I18n.locale.upcase
  end
end
