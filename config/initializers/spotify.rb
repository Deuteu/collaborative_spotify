if (client_id = ENV['SPOTIFY_ID']) && (client_secret = ENV['SPOTIFY_SECRET'])
  RSpotify.authenticate(client_id, client_secret)

  if RSpotify.client_token.present?
    Rails.logger.info("Spotify authenticate with #{client_id}")
  else
    Rails.logger.warn("Error during authentication with #{client_id}")
  end
end
