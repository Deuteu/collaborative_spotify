# frozen_string_literal: true

describe PlaylistElement do
  it 'must have a spotify id' do
    element = FactoryBot.build(:playlist_element, spotify_id: nil)

    expect(element).not_to be_valid
  end

  it 'must belong to a user' do
    element = FactoryBot.build(:playlist_element, user: nil)

    expect(element).not_to be_valid
  end

  it 'must be in a playlist' do
    element = FactoryBot.build(:playlist_element, playlist: nil)

    expect(element).not_to be_valid
  end

  context 'when removed date is set' do
    it 'cannot change removed date' do
      element = FactoryBot.create(:playlist_element, :removed)

      expect { element.update(removed_at: Time.current) }.
        not_to(change { element.reload.removed_at })
    end
  end

  describe '#remove' do
    let(:element) { FactoryBot.create(:playlist_element, removed_at: nil) }

    it 'sets the removed date' do
      element.remove

      expect(element.removed_at).not_to be_nil
    end

    it 'marks the element as removed' do
      element.remove

      expect(element.removed?).to be(true)
    end

    it 'marks the element as not active' do
      element.remove

      expect(element.active?).to be(false)
    end
  end

  describe '#track' do
    let(:element) { FactoryBot.create(:playlist_element) }

    before do
      allow(RSpotify::Track).to receive(:find).with(be_a(String)) do |spotify_id|
        FactoryBot.build(:track, id: spotify_id)
      end
    end

    context 'when track is not loaded' do
      it 'loads the track' do
        track = element.track

        expect(track).not_to be(nil)
        expect(RSpotify::Track).to have_received(:find).with(element.spotify_id)
        expect(element).to be_track_loaded
      end
    end

    context 'when track is loaded' do
      it 'uses the memoization' do
        element.load_track(FactoryBot.build(:track, id: element.spotify_id))

        track = element.track

        expect(track).not_to be(nil)
        expect(RSpotify::Track).not_to have_received(:find)
      end
    end
  end

  describe '#load_track' do
    let(:element) { FactoryBot.create(:playlist_element) }

    context 'when argument is a track' do
      it 'loads the track' do
        track = FactoryBot.build(:track)

        element.load_track(track)

        expect(element).to be_track_loaded
      end
    end

    context 'when argument is not a track' do
      it 'loads the track' do
        track = FactoryBot.build(:artist)

        element.load_track(track)

        expect(element).not_to be_track_loaded
      end
    end
  end

  describe '#duration' do
    let(:element) { FactoryBot.create(:playlist_element) }

    context 'when track is not available' do
      it 'returns 0' do
        allow(element).to receive(:track).and_return(nil)

        duration = element.duration

        expect(duration).to eq(0)
      end
    end

    context 'when track is available' do
      it 'returns the duration in sec rounded up' do
        track = FactoryBot.build(:track, duration_ms: 42_001)
        allow(element).to receive(:track).and_return(track)

        duration = element.duration

        expect(duration).to eq(43)
      end
    end
  end

  describe '#artist_name' do
    let(:element) { FactoryBot.create(:playlist_element) }

    context 'when track is not available' do
      it 'returns nil' do
        allow(element).to receive(:artists).and_return(nil)

        artist_name = element.artist_name

        expect(artist_name).to be(nil)
      end
    end

    context 'when track is available' do
      it 'returns the duration in sec rounded up' do
        artists = [
          FactoryBot.build(:artist, name: 'First'),
          FactoryBot.build(:artist, name: 'Second')
        ]
        allow(element).to receive(:artists).and_return(artists)

        artist_name = element.artist_name

        expect(artist_name).to eq('First, Second')
      end
    end
  end

  describe '.with_track' do
    let(:element_ids) { Array.new(3) { FactoryBot.create(:playlist_element).id } }

    context 'when the call to spotify API fails' do
      it 'returns the elements' do
        allow(RSpotify::CollectionRetriever).to receive(:get).and_raise(RSpotify::MissingAuthentication)

        elements = PlaylistElement.where(id: element_ids)
        elements_with_track = PlaylistElement.with_track(elements)

        expect(elements_with_track).to eq(elements)
      end
    end

    it 'loads track for elements' do
      allow(RSpotify::CollectionRetriever).to receive(:get).with(RSpotify::Track, be_a(Array)) do |_, ids|
        ids.each_with_object({}) do |id, tracks_by_id|
          tracks_by_id[id] = FactoryBot.build(:track, id: id)
        end
      end

      elements = PlaylistElement.with_track(PlaylistElement.where(id: element_ids))

      expect(elements).to all(be_track_loaded)
    end
  end
end
