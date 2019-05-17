# frozen_string_literal: true

class ApplicationController < ActionController::API
  unless Rails.application.config.consider_all_requests_local
    rescue_from StandardError do
      render json: {error: {key: :unknown}}, status: :internal_server_error
    end

    rescue_from RSpotify::MissingAuthentication do
      render json: {error: {key: :missing_auth}}, status: :bad_gateway
    end
  end
end
