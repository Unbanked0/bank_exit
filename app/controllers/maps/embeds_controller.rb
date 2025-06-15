module Maps
  class EmbedsController < ApplicationController
    content_security_policy do |policy|
      policy.frame_ancestors '*'
    end

    include Merchandable

    before_action :set_options
    before_action :set_merchants, :set_markers
    after_action :remove_frame_header

    attr_reader :country, :continent, :coins

    layout 'minimal'

    # @route GET /fr/map/embed {locale: "fr"}
    # @route GET /es/map/embed {locale: "es"}
    # @route GET /en/map/embed {locale: "en"}
    # @route GET /maps/embed
    def show
    end

    private

    def set_options
      @theme = {
        light: 'light',
        dark: Setting::DARK_THEME_NAME
      }[params[:theme]&.to_sym] || Setting::MAP_DEFAULT_THEME

      @latitude = params[:latitude]
      @longitude = params[:longitude]
      @zoom = params[:zoom]

      @continent = params[:continent]
      @country = params[:country] unless @continent

      @coins = params[:coins].presence || []

      @gesture_handling = params[:gestureHandling] != 'false'
      @fit_bounds = params[:fitBounds] == 'true'
      @use_clusters = params[:clusters] != 'false'
      @show_attribution = params[:attribution] != 'false'
    end

    # Remove default Rails header to allow map embedding
    # @see https://guides.rubyonrails.org/security.html#configuring-the-default-headers
    def remove_frame_header
      response.header.delete('X-Frame-Options')
    end
  end
end
