module Admin
  module Merchants
    class DirectoryConvertersController < ApplicationController
      before_action :set_merchant, only: %i[create]

      # @route POST /admin/merchants/:id/directory_converters (admin_directory_converters)
      def create
        authorize! @merchant, with: DirectoryConverterPolicy

        @directory = @merchant.to_directory!

        flash[:notice] = "L'entrée de l'annuaire a bien été créée. Pensez à la réactiver une fois les modifications effectuées"

        redirect_to edit_admin_directory_path(@directory)
      end

      private

      def set_merchant
        @merchant = Merchant.find_by!(identifier: merchant_id)
      end

      def merchant_id
        params[:id].split('-').first
      end
    end
  end
end
