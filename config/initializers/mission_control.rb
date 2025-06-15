Rails.application.configure do
  MissionControl::Jobs.base_controller_class = 'Admin::ApplicationController'
  MissionControl::Jobs.http_basic_auth_enabled = false
end
