class StatisticsController < ApplicationController
  include Statisticable

  before_action :set_statistics

  # @route GET /fr/stats {locale: "fr"} (statistics_fr)
  # @route GET /es/stats {locale: "es"} (statistics_es)
  # @route GET /de/stats {locale: "de"} (statistics_de)
  # @route GET /en/stats {locale: "en"} (statistics_en)
  # @route GET /statistics
  def show
  end
end
