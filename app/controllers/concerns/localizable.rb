module Localizable
  extend ActiveSupport::Concern

  included do
    before_action :redirect_to_localized_path, if: :should_redirect_to_localized_path?
    around_action :switch_locale

    helper_method :find_locale
  end

  def redirect_to_localized_path
    redirect_to url_for(
      locale: find_locale,
      params: request.query_parameters,
      only_path: true
    )
  end

  private

  def should_redirect_to_localized_path?
    return false if params[:locale].present?

    !controller_path.in?(
      ['licenses', 'maps', 'maps/referers', 'addresses/searches']
    ) &&
      !action_name.in?(['toggle_atms'])
  end

  def switch_locale(&)
    locale = find_locale.to_sym
    session[:last_known_locale] = locale

    I18n.with_locale(locale, &)
  end

  def find_locale
    locale_from_params ||
      locale_from_session ||
      locale_from_browser ||
      I18n.default_locale.to_s
  end

  def locale_from_params
    normalize_locale(params[:locale])
  end

  def locale_from_session
    normalize_locale(session[:last_known_locale])
  end

  def locale_from_browser
    normalize_locale(request.get_header('HTTP_ACCEPT_LANGUAGE')&.first(2))
  end

  def normalize_locale(locale)
    return if locale.blank?

    locale = locale.to_s.downcase
    locale if locale.in?(available_locales)
  end

  def available_locales
    @available_locales ||= I18n.available_locales.map(&:to_s)
  end
end
