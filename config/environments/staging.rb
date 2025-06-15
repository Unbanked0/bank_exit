# Staging configuration is identical to production with some
# overrides.
require_relative 'production'

host = 'staging.bank-exit.org'

Rails.application.configure do
  config.action_controller.default_url_options = { host: host }
  config.action_mailer.default_url_options = { host: host }
end

Rails.application.routes.default_url_options[:host] = host
