module AuthHelper
  def basic_auth_headers(username: valid_username, password: valid_password)
    credentials = ActionController::HttpAuthentication::Basic.encode_credentials(username, password)
    { Authorization: credentials }
  end

  def valid_username
    ENV.fetch('HTTP_BASIC_AUTH_USERNAME', nil)
  end

  def valid_password
    ENV.fetch('HTTP_BASIC_AUTH_PASSWORD', nil)
  end
end
