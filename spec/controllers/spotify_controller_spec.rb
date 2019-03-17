# frozen_string_literal: true

describe SpotifyController do
  describe '#search' do
    let(:search_result) { [{key: 'value'}] }

    before(:each) do
      allow(RSpotify::Track).to receive(:search).and_return(search_result)
    end

    it 'returns a 200 status' do
      get :search
      expect(response).to have_http_status(:ok)
    end

    let(:parsed_body) { JSON.parse(response.body) }

    it 'renders the RSpotify search result' do
      get :search
      expect(response.content_type).to eq('application/json')
      expect { parsed_body }.not_to raise_error
      expect(parsed_body).to eq(search_result.map(&:stringify_keys))
    end
  end
end
