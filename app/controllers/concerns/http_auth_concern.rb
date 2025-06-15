module HttpAuthConcern
  extend ActiveSupport::Concern

  included do
    before_action :http_authenticate
  end

  private

  def http_authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV.fetch('HTTP_BASIC_AUTH_USERNAME') &&
        password == ENV.fetch('HTTP_BASIC_AUTH_PASSWORD')
    end
  end
end
