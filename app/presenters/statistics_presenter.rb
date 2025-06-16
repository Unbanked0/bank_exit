class StatisticsPresenter < ApplicationPresenter
  include ApplicationHelper

  WEST_EUROPEAN_COUNTRIES = %w[FR GB ES PT DE IT CH BE].freeze
  NORTH_AMERICA_COUNTRIES = %w[CA US MX CU AU NZ].freeze
  SOUTH_AMERICA_COUNTRIES = %w[BR AR BO PY UY CL].freeze

  attr_reader :today, :yesterday

  def initialize
    @today = Time.current
    @yesterday = 1.day.ago
  end

  def merchants_statistics
    {
      enabled: merchants_enabled,
      today: today_merchants,
      yesterday: yesterday_merchants,
      two_weeks_range: merchants_two_weeks_range,
      merchants_west_europe_and_days: merchants_west_europe_and_days,
      merchants_north_america_and_days: merchants_north_america_and_days,
      merchants_south_america_and_days: merchants_south_america_and_days
    }
  end

  def countries_statistics
    {
      by_countries: merchants_by_countries,
      monero_in_france: merchants_monero_in_france,
      monero_in_france_by_week: merchants_monero_in_france_by_week,
      monero_by_country: merchants_monero_by_country,
      june_by_country: merchants_june_by_country
    }
  end

  def categories_statistics
    {
      by_main_categories: merchants_main_categories,
      main_category: merchant_main_category
    }
  end

  def coins_statistics
    {
      monero_world: merchants_monero_world,
      june_world: merchants_june_world,
      by_coins: merchants_coins
    }
  end

  def directories_statistics
    {
      enabled: directories_enabled,
      by_day: directories_by_day
    }
  end

  private

  def merchants_enabled
    base_merchants.count
  end

  def today_merchants
    base_merchants
      .where(created_at: today.all_day)
  end

  def yesterday_merchants
    base_merchants
      .where(created_at: yesterday.all_day)
  end

  def merchants_two_weeks_range
    base_merchants
      .group_by_day(
        :created_at, range: 2.weeks.ago..Time.current
      )
      .count
      .map { |k, v| [I18n.l(k, format: :short), v] }
  end

  def merchants_monero_in_france
    @merchants_monero_in_france ||= base_merchants.monero.by_country('FR')
  end

  def merchants_monero_in_france_by_week
    merchants_monero_in_france.group_by_week(:created_at, range: 2.months.ago..Time.current).count.map do |k, v|
      [I18n.l(k, format: :short), v]
    end
  end

  def merchants_monero_by_country
    base_merchants.monero.group(:country).count.map do |k, v|
      next unless v >= 3

      [pretty_country_html(k, show_flag: true), v]
    end.compact_blank
  end

  def merchants_june_by_country
    base_merchants.june.group(:country).count.map do |k, v|
      [pretty_country_html(k, show_flag: true), v]
    end
  end

  def merchants_by_countries
    base_merchants
      .where(country: WEST_EUROPEAN_COUNTRIES)
      .group(:country).count.map do |k, v|
      [pretty_country_html(k, show_flag: true), v]
    end
  end

  def merchants_west_europe_and_days
    merchants_by_area_and_days(WEST_EUROPEAN_COUNTRIES)
  end

  def merchants_north_america_and_days
    merchants_by_area_and_days(NORTH_AMERICA_COUNTRIES)
  end

  def merchants_south_america_and_days
    merchants_by_area_and_days(SOUTH_AMERICA_COUNTRIES)
  end

  def merchants_by_area_and_days(
    area,
    range_start: 2.weeks.ago.beginning_of_day,
    range_end: Time.current.end_of_day
  )
    range = range_start..range_end

    area.each_with_object({}) do |country, hash|
      label = pretty_country_html(country, show_flag: true)
      base_merchants
        .where(country: country)
        .where(created_at: range)
        .group_by_day(:created_at, range: range)
        .count
        .map do |date, count|
        hash[
          [label, I18n.l(date, format: :short)]
        ] = count
      end
    end
  end

  def merchant_main_category
    base_merchants
      .select(:category)
      .group(:category)
      .count
      .max_by { it[1] }
  end

  def merchants_main_categories
    base_merchants
      .where(category: %w[bar cafe restaurant grocery farm])
      .group(:category).count.map do |k, v|
      [I18n.t(k, scope: :categories), v]
    end
  end

  def merchants_monero_world
    base_merchants.monero
  end

  def merchants_june_world
    base_merchants.june
  end

  def merchants_coins
    base_merchants.pluck(:coins).flatten.tally.map do |k, v|
      [k.capitalize, v]
    end
  end

  def directories_enabled
    Directory.enabled
  end

  def directories_by_day
    directories_enabled
      .group_by_day(
        :created_at,
        range: 1.month.ago..Date.current
      )
      .count.map do |k, v|
        [I18n.l(k, format: :short), v]
      end
  end

  def base_merchants
    @base_merchants ||= Merchant.available.not_atms
  end
end
