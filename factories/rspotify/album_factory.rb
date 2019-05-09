# frozen_string_literal: true

FactoryBot.define do
  factory :album, parent: :rspotify_base, class: RSpotify::Album do
    transient do
      type { 'album' }
    end

    transient do
      name { 'EP' }
      popularity { 50 }
    end

    trait :partially_loaded do
      transient do
        popularity { nil }
      end
    end

    initialize_with do
      new(
        base.merge(
          {
            type: type,
            name: name,
            popularity: popularity
          }.with_indifferent_access
        )
      )
    end
  end
end
