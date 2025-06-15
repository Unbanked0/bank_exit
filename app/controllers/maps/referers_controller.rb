module Maps
  class ReferersController < ApplicationController
    # @route PATCH /maps/referer (maps_referer)
    # @route PUT /maps/referer (maps_referer)
    def update
      session[:map_referer_url] = params[:map_referer_url]

      head :ok
    end
  end
end
