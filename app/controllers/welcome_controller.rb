class WelcomeController < PublicController
  include Statisticable

  before_action :resume_session
  before_action :set_statistics

  # @route GET /fr {locale: "fr"} (root_fr)
  # @route GET /es {locale: "es"} (root_es)
  # @route GET /de {locale: "de"} (root_de)
  # @route GET /it {locale: "it"} (root_it)
  # @route GET /en {locale: "en"} (root_en)
  # @route GET / (root)
  def index
    @coins = Coin.all(decorate: true)
    @profiles = Questions::BuildProfiles.call
    @levels = Questions::BuildLevels.call

    merchants_sample = Merchant.available.monero.in_france.no_kyc.includes(:logo_attachment, :banner_attachment).sample(4)
    @merchants_sample = MerchantDecorator.wrap(merchants_sample)
  end

  # TODO: Remove code once a new Rails version is released
  # @see https://github.com/rails/rails/pull/57184
  # @route GET /offline (pwa_offline)
  def offline
    render template: 'pwa/offline', layout: false
  end
end
