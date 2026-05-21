class SessionsController < PublicController
  before_action :require_authentication, only: :destroy
  skip_after_action :record_page_view

  rate_limit to: 10, within: 3.minutes, only: :create,
             with: -> { redirect_to new_session_path, alert: 'Try again later.' },
             by: -> { encrypted_ip }

  # @route GET /fr/session/new {locale: "fr"} (new_session_fr)
  # @route GET /es/session/new {locale: "es"} (new_session_es)
  # @route GET /de/session/new {locale: "de"} (new_session_de)
  # @route GET /it/session/new {locale: "it"} (new_session_it)
  # @route GET /en/session/new {locale: "en"} (new_session_en)
  # @route GET /session/new
  def new
    redirect_to admin_root_path if authenticated?
  end

  # @route POST /fr/session {locale: "fr"} (session_fr)
  # @route POST /es/session {locale: "es"} (session_es)
  # @route POST /de/session {locale: "de"} (session_de)
  # @route POST /it/session {locale: "it"} (session_it)
  # @route POST /en/session {locale: "en"} (session_en)
  # @route POST /session
  def create
    user = User.authenticate_by(params.permit(:email_address, :password))

    if user&.enabled?
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to new_session_path, alert: t('.alert')
    end
  rescue ArgumentError
    redirect_to new_session_path, alert: t('.alert')
  end

  # @route DELETE /fr/session {locale: "fr"} (session_fr)
  # @route DELETE /es/session {locale: "es"} (session_es)
  # @route DELETE /de/session {locale: "de"} (session_de)
  # @route DELETE /it/session {locale: "it"} (session_it)
  # @route DELETE /en/session {locale: "en"} (session_en)
  # @route DELETE /session
  def destroy
    terminate_session
    redirect_to new_session_path, status: :see_other
  end

  private

  def session_params
    params.expect(session: %i[email_address password])
  end
end
