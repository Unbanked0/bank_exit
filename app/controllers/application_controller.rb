class ApplicationController < ActionController::Base
  prepend ActionPolicy::SimpleDelegator
  include HttpAuthConcern if Rails.env.staging?
  include Pagy::Backend

  rate_limit to: 100, within: 1.minute, by: -> { encrypted_ip }

  rescue_from ActionPolicy::Unauthorized, with: :unauthorized_access

  around_action :switch_locale
  before_action :set_projects
  before_action :set_contacts

  helper_method :comments_enabled?

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  # Mandatory for ActionPolicy authorization check
  def current_user
  end

  private

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def set_projects
    @projects = Project.all(decorate: true)
  end

  def set_contacts
    @contacts = Contact.all
  end

  def comments_enabled?
    ENV.fetch('FF_COMMENTS_ENABLED', 'true') == 'true'
  end

  def unauthorized_access(e)
    policy_name = e.policy.class.to_s.underscore
    message = t("#{policy_name}.#{e.rule}", scope: 'pundit', default: :default)

    redirect_back_or_to root_path, alert: message
  end

  # Remove empty GET params from URL
  def clean_url(url)
    uri = URI.parse(url)
    query = Rack::Utils.parse_nested_query(uri.query).compact_blank
    uri.query = query.to_query.presence
    uri.to_s
  end

  def encrypted_ip
    Digest::SHA256.hexdigest(request.remote_ip)
  end
end
