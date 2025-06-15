class MerchantsController < ApplicationController
  before_action :set_merchant, only: :show

  # @route GET /fr/commercants/:id {locale: "fr"} (merchant_fr)
  # @route GET /es/comerciantes/:id {locale: "es"} (merchant_es)
  # @route GET /en/merchants/:id {locale: "en"} (merchant_en)
  # @route GET /merchants/:id
  def show
    set_meta_tags title: @merchant.name

    return unless comments_enabled?

    comments = CommentDecorator.wrap(@merchant.comments)
    @pagy, @comments = pagy_array(comments, limit: 5)
  end

  # @route POST /fr/commercants/refresh {locale: "fr"} (refresh_merchants_fr)
  # @route POST /es/comerciantes/refresh {locale: "es"} (refresh_merchants_es)
  # @route POST /en/merchants/refresh {locale: "en"} (refresh_merchants_en)
  # @route POST /merchants/refresh
  def refresh
    respond_to do |format|
      format.turbo_stream do
        FetchMerchants.call_later
        flash.now[:notice] = t('.notice')
      end
    end
  end

  private

  def set_merchant
    @merchant = Merchant.find_by!(identifier: merchant_id).decorate
  rescue ActiveRecord::RecordNotFound
    # Indicates to search engines that some already referenced
    # merchants URLs have been removed by using a permanent
    # redirection to the map page.
    redirect_to maps_path, status: :moved_permanently
  end

  def merchant_id
    params[:id].split('-').first
  end
end
