# frozen_string_literal: true

class SpotifyController < ApplicationController
  def search
    RSpotify.raw_response = params[:raw].present?
    render json: RSpotify::Track.search(params[:q] || 'Michel Berger', limit: 3)
  end
end
