# frozen_string_literal: true

FactoryBot.define do
  factory :track, parent: :rspotify_base, class: RSpotify::Track do
    skip_create

    transient do
      type { 'artist' }
    end

    transient do
      album { FactoryBot.create(:album, :partially_loaded) }
      artists { [FactoryBot.create(:artist, :partially_loaded)] }
      available_markets { %w[FR JP US] }
      disc_number { 1 }
      duration_ms { 5.minutes.to_i * 1000 }
      explicit { false }
      external_ids { {} }
      name { 'Awesome track' }
      popularity { 50 }
      preview_url { 'https://google.com' }
      track_number { 1 }

      played_at { nil }
      context_type { nil }
      is_playable { true }
      # TrackLink linked_from
    end

    trait :give_you_up do
      transient do
        id { '7GhIk7Il098yCjg4BQjzvb' }

        # album
        artists { [FactoryBot.create(:artist, :astley, :partially_loaded)] }
        available_markets { %w[AR BO BR CA CH DO EC GT FR HK HN ID IN JP NI PA PE PH PY SG SV TH TW US UY VN] }
        disc_number { 1 }
        duration_ms { 212_826 }
        explicit { false }
        external_ids { {isrc: 'GBARL9300135'}.with_indifferent_access }
        name { 'Never Gonna Give You Up' }
        popularity { 66 }
        preview_url { 'https://p.scdn.co/mp3-preview/22bf10aff02db272f0a053dff5c0063d729df988?cid=f429200f78eb44649c4e9467ffb60940' }
        track_number { 1 }
      end
    end

    trait :sandstorm do
      transient do
        id { '6Sy9BUbgFse0n0LPA5lwy5' }

        # album
        artists { [FactoryBot.create(:artist, :darude, :partially_loaded)] }
        available_markets { nil }
        disc_number { 1 }
        duration_ms { 225_493 }
        explicit { false }
        external_ids { {isrc: 'FISGC9900001'}.with_indifferent_access }
        name { 'Sandstorm' }
        popularity { 69 }
        preview_url { 'https://p.scdn.co/mp3-preview/ef1fbd441eb8576dcc7c44a67dff75db0d712d28?cid=f429200f78eb44649c4e9467ffb60940' }
        track_number { 4 }
      end
    end

    initialize_with do
      new(
        base.merge(
          {
            type: type,
            album: album&.as_json,
            artists: artists&.map(&:as_json),
            available_markets: available_markets,
            disc_number: disc_number,
            duration_ms: duration_ms,
            explicit: explicit,
            external_ids: external_ids,
            name: name,
            popularity: popularity,
            preview_url: preview_url,
            track_number: track_number,
            played_at: played_at,
            context_type: context_type,
            is_playable: is_playable
          }.with_indifferent_access
        )
      )
    end
  end
end
