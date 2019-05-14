# frozen_string_literal: true

class TracksController < ApplicationController
  def search
    if search_query.blank?
      render status: :bad_request, json: {}
      return
    end

    if search_limit < 1 || search_limit > 30
      # Spotify limit: 50
      render status: :bad_request, json: {}
      return
    end

    results = PlaylistElement.search(search_query, limit: search_limit)

    render status: :ok, json: results
  end

  private

  def search_limit
    @search_limit ||= (params[:limit] || 10).to_i
  end

  def search_query
    @search_query ||= params[:q]
  end
end
