class MerchantProposalsController < ApplicationController
  before_action :set_faqs, only: :new

  add_breadcrumb proc { I18n.t('application.nav.menu.home') }, :root_path
  add_breadcrumb proc { I18n.t('application.nav.menu.map') }, :map_referer_path

  # @route GET /fr/merchant_proposals {locale: "fr"} (merchant_proposals_fr)
  # @route GET /es/merchant_proposals {locale: "es"} (merchant_proposals_es)
  # @route GET /en/merchant_proposals {locale: "en"} (merchant_proposals_en)
  # @route GET /merchant_proposals
  def index
    redirect_to new_merchant_proposal_path
  end

  # @route GET /fr/merchant_proposals/new {locale: "fr"} (new_merchant_proposal_fr)
  # @route GET /es/merchant_proposals/new {locale: "es"} (new_merchant_proposal_es)
  # @route GET /en/merchant_proposals/new {locale: "en"} (new_merchant_proposal_en)
  # @route GET /merchant_proposals/new
  def new
    add_breadcrumb t('.title'), new_merchant_proposal_path

    @merchant_proposal = MerchantProposal.new
  end

  # @route POST /fr/merchant_proposals {locale: "fr"} (merchant_proposals_fr)
  # @route POST /es/merchant_proposals {locale: "es"} (merchant_proposals_es)
  # @route POST /en/merchant_proposals {locale: "en"} (merchant_proposals_en)
  # @route POST /merchant_proposals
  def create
    @merchant_proposal = MerchantProposal.new(merchant_proposal_params)

    if @merchant_proposal.nickname.present?
      # Captcha used to trick a spammer making him to think
      # that email has actually been sent.
      Rails.logger.warn { "Spam detected nickname: #{@merchant_proposal.nickname}" }

      redirect_to maps_path, notice: t('.notice')
    elsif @merchant_proposal.valid?
      if Rails.env.test? || Rails.env.production?
        # Only call the Github API issue in production
        MerchantProposalIssue.call(@merchant_proposal)
      end

      MerchantMailer
        .with(data: merchant_proposal_params)
        .send_new_merchant
        .deliver_later

      redirect_to maps_path, notice: t('.notice')
    else
      set_faqs

      render :new, status: :unprocessable_entity
    end
  rescue StandardError => e
    redirect_to maps_path, alert: e.message
  end

  private

  def merchant_proposal_params
    params.expect(merchant_proposal: [
                    :name, :category, :other_category,
                    :description,
                    :street, :postcode, :city, :country,
                    :phone, :website, :email,
                    :contact_session, :contact_signal,
                    :contact_matrix, :contact_jabber, :contact_telegram,
                    :contact_facebook, :contact_instagram, :contact_twitter,
                    :contact_youtube, :contact_tiktok, :contact_linkedin,
                    :contact_tripadvisor, :contact_odysee,
                    :delivery, :delivery_zone, :opening_hours,
                    :last_survey_on, :nickname, :ask_kyc,
                    :proposition_from,
                    { coins: [] }
                  ])
  end

  def set_faqs
    @faqs = FAQ.all.select do |faq|
      'kyc'.in?(faq.categories)
    end
  end
end
