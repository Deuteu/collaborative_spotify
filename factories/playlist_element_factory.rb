# frozen_string_literal: true

FactoryBot.define do
  factory :playlist_element do
    playlist { FactoryBot.create(:playlist) }
    user { FactoryBot.create(:user) }

    sequence(:spotify_id) { |n| "spotify_#{n.to_s.rjust(5, '0')}" }

    created_at { Time.current }
    updated_at { created_at }
    removed_at { nil }

    trait :removed do
      removed_at { Time.current }
      created_at { removed_at - 2.seconds }
    end
  end
end
