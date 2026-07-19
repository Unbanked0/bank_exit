module Admin
  class BaseController < ApplicationController
    include Localizable
    include Themable

    layout 'admin'

    before_action :set_bell_counter

    add_breadcrumb proc { I18n.t('admin.dashboards.show.title') }, :admin_dashboard_path

    private

    def set_bell_counter
      @bell_counter = {}

      @bell_counter[:deleted_merchants] = Merchant.deleted.any? if allowed_to?(:index?, Merchant, with: Admin::MerchantPolicy)

      return unless allowed_to?(:index?, Comment, with: Admin::CommentPolicy)

      @bell_counter[:flagged_comments] = Comment.flagged.any?
    end

    def should_redirect_to_localized_path?
      false
    end
  end
end
