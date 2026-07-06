class PublicController < ApplicationController
  allow_unauthenticated_access

  include Localizable
  include Analyticable
  include Themable

  before_action :set_projects
  before_action :set_contacts
  before_action :set_default_search_merchants, if: :full_page_request?

  private

  def set_projects
    @projects = Project.all(decorate: true)
  end

  def set_contacts
    @contacts = Contact.all
  end

  def set_default_search_merchants
    if params[:page].nil? || params.expect(:page).to_i == 1
      directories_filter = Directories::Filter.new(query: query)
      @directories = DirectoryDecorator.wrap(directories_filter.call)
    end

    @pagy, merchants = pagy(Merchant.available.by_query(query).with_attached_logo.order(last_survey_on: :desc))
    @merchants = MerchantDecorator.wrap(merchants)
  end

  def full_page_request?
    request.format.html? && !turbo_frame_request?
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

  def query
    nil
  end
end
