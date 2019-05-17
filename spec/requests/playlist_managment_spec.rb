# frozen_string_literal: true

describe 'Playlist management', api: true do
  include SpotifyMock

  describe 'index' do
    before do
      FactoryBot.create_list(:playlist, 5)

      get '/api/playlists'
    end

    include_examples :returns_ok
    include_examples :renders_json

    it 'lists all playlist' do
      expect(parsed_response.length).to eq(5)
    end
  end

  describe 'tracks index' do
    context 'with unknown playlist id' do
      before do
        get '/api/playlists/0/tracks'
      end

      include_examples :returns_not_found
      include_examples :renders_json
    end

    context 'with known playlist id' do
      before do
        playlist_id = FactoryBot.create(:playlist).id
        FactoryBot.create_list(:playlist_element, 3, :removed, playlist_id: playlist_id)
        FactoryBot.create_list(:playlist_element, 7, playlist_id: playlist_id)

        mock_find_tracks

        get "/api/playlists/#{playlist_id}/tracks"
      end

      include_examples :returns_ok
      include_examples :renders_json

      it 'lists all active tracks' do
        expect(parsed_response).to be_a(Array)
        expect(parsed_response.length).to eq(7)
      end
    end
  end

  describe 'track add' do
    context 'with unknown playlist' do
      before do
        post '/api/playlists/0/tracks'
      end

      include_examples :returns_not_found
      include_examples :renders_json
    end

    context 'with known playlist' do
      let(:playlist_id) { FactoryBot.create(:playlist).id }

      context 'with no track id' do
        before do
          post "/api/playlists/#{playlist_id}/tracks", params: {track_id: nil}
        end

        include_examples :returns_bad_request
        include_examples :renders_json
      end

      context 'with unknown track id' do
        before do
          failed = true
          mock_find_track(failed)

          post "/api/playlists/#{playlist_id}/tracks", params: {track_id: FactoryBot.build(:track).id}, headers: json_header

          include_examples :returns_not_found
          include_examples :renders_json
        end
      end

      context 'with known track id' do
        before do
          mock_find_track
        end

        context 'when track add fail' do
          before do
            playlist = Playlist.find(playlist_id)
            allow(Playlist).to(
              receive(:find_by).
                with(hash_including(:id)).
                and_return(playlist)
            )
            allow(playlist).to receive_message_chain(:elements, :create) do |**args|
              PlaylistElement.new(args)
            end
          end

          before do
            post "/api/playlists/#{playlist_id}/tracks", params: {track_id: FactoryBot.build(:track).id}, headers: json_header
          end

          include_examples :returns_unprocessable_entity
          include_examples :renders_json
        end

        context 'when track add succeed' do
          before do
            # Needed temporarily until user logic is implemented
            FactoryBot.create(:user)
          end

          before do
            post "/api/playlists/#{playlist_id}/tracks", params: {track_id: FactoryBot.build(:track).id}
          end

          include_examples :returns_created
          include_examples :renders_json

          it 'contains the details of the track' do
            expect(parsed_response).to have_key('id')
          end
        end
      end
    end
  end
end
