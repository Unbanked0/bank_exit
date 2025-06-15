module Merchants
  class PopupsController < ApplicationController
    before_action :set_merchant

    # @route GET /fr/commercants/:merchant_id/popup {locale: "fr"} (merchant_popup_fr)
    # @route GET /es/comerciantes/:merchant_id/popup {locale: "es"} (merchant_popup_es)
    # @route GET /en/merchants/:merchant_id/popup {locale: "en"} (merchant_popup_en)
    # @route GET /merchants/:merchant_id/popup
    def show
      render layout: false
    end

    private

    def set_merchant
      @merchant = Merchant.find_by!(identifier: merchant_id).decorate
    end

    def merchant_id
      params[:merchant_id].split('-').first
    end
  end
end
