class WelcomeController < ApplicationController
  include Merchandable
  include Statisticable

  before_action :set_merchants
  before_action :set_markers
  before_action :set_statistics

  # @route GET /fr {locale: "fr"} (root_fr)
  # @route GET /es {locale: "es"} (root_es)
  # @route GET /en {locale: "en"} (root_en)
  # @route GET / (root)
  def index
    @coins = Coin.all(decorate: true)
    @highlighted_tutorials = Tutorial.all(decorate: true).select(&:highlight?)

    @faqs = FAQ.all.first(3)
    @minimal_faq = true

    @profiles = Questions::BuildProfiles.call
    @levels = Questions::BuildLevels.call

    merchants_sample = Merchant.monero.in_france.no_kyc.sample(3)
    @merchants_sample = MerchantDecorator.wrap(merchants_sample)
  end
end
