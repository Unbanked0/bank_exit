module Admin
  module Merchants
    class AssignCountriesController < BaseController
      # @route POST /fr/admin/merchants/assign_countries {locale: "fr"} (admin_merchants_assign_countries_fr)
      # @route POST /es/admin/merchants/assign_countries {locale: "es"} (admin_merchants_assign_countries_es)
      # @route POST /de/admin/merchants/assign_countries {locale: "de"} (admin_merchants_assign_countries_de)
      # @route POST /it/admin/merchants/assign_countries {locale: "it"} (admin_merchants_assign_countries_it)
      # @route POST /en/admin/merchants/assign_countries {locale: "en"} (admin_merchants_assign_countries_en)
      # @route POST /admin/merchants/assign_countries
      def create
        authorize! with: Admin::Merchants::AssignCountriesPolicy

        ::Merchants::AssignCountry.call_later

        flash[:notice] = t('.notice')

        redirect_to admin_merchants_path
      end
    end
  end
end
