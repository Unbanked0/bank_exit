module Admin
  class BaseController < ApplicationController
    include Localizable
    include Themable

    layout 'admin'

    add_breadcrumb proc { I18n.t('admin.dashboards.show.title') }, :admin_dashboard_path

    private

    def should_redirect_to_localized_path?
      false
    end
  end
end
