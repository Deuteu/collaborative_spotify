# frozen_string_literal: true

FactoryBot.define do
  factory :artist, parent: :rspotify_base, class: RSpotify::Artist do
    transient do
      type { 'artist' }
    end

    transient do
      followers { {href: nil, total: 42}.with_indifferent_access }
      genres { ['music'] }
      images do
        [
          {
            height: 640,
            url: 'https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png',
            width: 640
          }.with_indifferent_access
        ]
      end
      name { 'Henri' }
      popularity { 50 }
    end

    trait :astley do
      transient do
        id { '0gxyHStUsqpMadRV0Di1Qt' }

        followers { {href: nil, total: 381_858}.with_indifferent_access }
        genres { ['dance pop', 'dance rock', 'disco', 'europop', 'new romantic', 'new wave', 'new wave pop', 'soft rock'] }
        images do
          [
            {height: 640, url: 'https://i.scdn.co/image/3ba3e4b47ee189c442b908d5df2d2d488260726c', width: 640},
            {height: 320, url: 'https://i.scdn.co/image/980def33ff6809fb83de560e7238c9166b23fb33', width: 320},
            {height: 160, url: 'https://i.scdn.co/image/fe4c381da95d5d350282b0140107af19b69aef65', width: 160}
          ].map(&:with_indifferent_access)
        end
        name { 'Rick Astley' }
        popularity { 66 }
      end
    end

    trait :darude do
      transient do
        id { '0gxyHStUsqpMadRV0Di1Qt' }

        followers { {href: nil, total: 86_292}.with_indifferent_access }
        genres { ['eurodance', 'europop', 'finnish edm'] }
        images do
          [
            {height: 640, url: 'https://i.scdn.co/image/49fd2655e359c258a440437940ee3d0d3171084f', width: 640},
            {height: 320, url: 'https://i.scdn.co/image/068f53c3228083e38eeeb5cd5118f9ec53a9b432', width: 320},
            {height: 160, url: 'https://i.scdn.co/image/92f31df7f91a063a16f3bb456f7ba0c13c08b6a8', width: 160}
          ].map(&:with_indifferent_access)
        end
        name { 'Darude' }
        popularity { 62 }
      end
    end

    trait :partially_loaded do
      transient do
        followers { nil }
        genres { nil }
        images { nil }
        popularity { nil }
      end
    end

    initialize_with do
      new(
        base.merge(
          {
            type: type,
            followers: followers,
            genres: genres,
            images: images,
            name: name,
            popularity: popularity
          }.with_indifferent_access
        )
      )
    end
  end
end
