class FilterMerchants < ApplicationService
  attr_reader :initial_scope, :query, :category,
              :country, :continent, :coins,
              :delivery, :no_kyc, :with_atms

  def initialize(initial_scope = Merchant.available, query: '', category: 'all', country: 'all', continent: 'all', coins: [], delivery: false, no_kyc: false, with_atms: false)
    @initial_scope = initial_scope
    @query = query
    @category = category
    @country = country
    @continent = continent
    @coins = coins
    @delivery = delivery
    @no_kyc = no_kyc
    @with_atms = with_atms
  end

  def call
    @merchants = initial_scope
    @merchants = @merchants.where(delivery: delivery) if delivery
    @merchants = @merchants.by_query(query) if query.present?
    @merchants = @merchants.by_category(category) if category.present? && category != 'all'

    # Ignore country if both params are present
    if continent.present? && continent != 'all'
      @merchants = @merchants.by_continent(continent)
    elsif country.present? && country != 'all'
      @merchants = @merchants.by_country(country)
    end

    @merchants = @merchants.no_kyc if no_kyc
    @merchants = @merchants.not_atms unless with_atms

    return @merchants unless bitcoin? || monero? || june?

    @merchants.and(
      Merchant.none.or(
        bitcoin? ? Merchant.merge(Merchant.bitcoin) : Merchant.none
      ).or(
        monero? ? Merchant.merge(Merchant.monero) : Merchant.none
      ).or(
        june? ? Merchant.merge(Merchant.june) : Merchant.none
      )
    )
  end

  private

  def bitcoin?
    coins.include?('bitcoin')
  end

  def monero?
    coins.include?('monero')
  end

  def june?
    coins.include?('june')
  end
end
