# frozen_string_literal: true

describe PlaylistElementSerializer do
  describe '#id' do
    it 'returns the track id' do
      element = FactoryBot.build(:playlist_element)
      element.load_track(FactoryBot.build(:track, id: element.spotify_id))

      serializer = PlaylistElementSerializer.new(element)

      expect(serializer.id).to eq(element.track_id)
    end
  end
end
