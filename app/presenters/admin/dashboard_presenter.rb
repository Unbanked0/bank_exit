module Admin
  class DashboardPresenter < StatisticsPresenter
    include MerchantsHelper

    private

    def today_merchants
      scope = base_merchants.where(
        created_at: today.beginning_of_day..today
      )

      MerchantDecorator
        .wrap(scope)
        .map(&:to_osm_map)
    end
  end
end
