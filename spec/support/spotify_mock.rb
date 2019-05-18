# frozen_string_literal: true

module SpotifyMock
  def mock_find_tracks
    allow(RSpotify::Base).to receive(:find).with(be_a(Array), 'track', any_args) do |ids, _type|
      ids.map { |id| FactoryBot.build(:track, id: id) }
    end
  end

  def mock_find_track(failed = false)
    allow(RSpotify::Base).to receive(:find).with(be_a(String), 'track', any_args) do |id, _type|
      FactoryBot.build(:track, id: id) unless failed
    end
  end

  def mock_search_track
    allow(RSpotify::Base).to receive(:search).with(be_a(String), 'track', any_args) do |_search, _type, args|
      Array.new(args[:limit].to_i) { FactoryBot.build(:track) }
    end
  end
end
