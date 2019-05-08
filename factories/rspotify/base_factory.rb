# frozen_string_literal: true

FactoryBot.define do
  factory :rspotify_base, class: RSpotify::Base do
    skip_create

    transient do
      sequence(:id) { |n| "spotify_#{n.to_s.rjust(5, '0')}" }

      external_urls { {spotify: "https://open.spotify.com/track/#{id}"}.with_indifferent_access }
      href { "https://api.spotify.com/v1/tracks/#{id}" }
      uri { "spotify:#{type}:#{id}" }

      base do
        {
          id: id,
          external_urls: external_urls,
          href: href,
          uri: uri
        }.with_indifferent_access
      end
    end
  end
end
