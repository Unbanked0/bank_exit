module Merchants
  class CommentsController < ApplicationController
    before_action :set_merchant

    # @route GET /fr/merchants/:merchant_id/comments/new {locale: "fr"} (new_merchant_comment_fr)
    # @route GET /es/merchants/:merchant_id/comments/new {locale: "es"} (new_merchant_comment_es)
    # @route GET /en/merchants/:merchant_id/comments/new {locale: "en"} (new_merchant_comment_en)
    # @route GET /merchants/:merchant_id/comments/new
    def new
      authorize! Comment

      respond_to do |format|
        format.turbo_stream do
          @comment = @merchant.comments.new(rating: nil)
        end
      end
    end

    # @route POST /fr/merchants/:merchant_id/comments {locale: "fr"} (merchant_comments_fr)
    # @route POST /es/merchants/:merchant_id/comments {locale: "es"} (merchant_comments_es)
    # @route POST /en/merchants/:merchant_id/comments {locale: "en"} (merchant_comments_en)
    # @route POST /merchants/:merchant_id/comments
    def create
      authorize! Comment

      @comment = @merchant.comments.new(comment_params) do |model|
        model.language = I18n.locale
      end
      @comment = @comment.decorate

      if @comment.nickname.present?
        # Prank bot with a 200
        flash.now[:notice] = t('.notice')
        head :ok
      elsif @comment.save
        flash.now[:notice] = t('.notice')
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def comment_params
      params.expect(comment: %i[content rating pseudonym affidavit nickname])
    end

    def set_merchant
      @merchant = Merchant.find_by!(identifier: merchant_id).decorate
    end

    def merchant_id
      params[:merchant_id].split('-').first
    end
  end
end
