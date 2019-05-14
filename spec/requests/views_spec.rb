# frozen_string_literal: true

describe 'Views' do
  shared_examples :renders_home do
    it 'returns a ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders a html response' do
      expect(response.content_type).to eq('text/html')
    end

    it 'uses the home template' do
      expect(response).to have_rendered(:home)
    end
  end

  describe 'home' do
    before do
      get '/'
    end

    include_examples :renders_home
  end

  describe 'undefined path' do
    context 'starting by api/' do
      it 'does not match' do
        expect { get '/api/undefined/path' }.to raise_error(ActionController::RoutingError)
      end
    end

    context 'not starting by api/' do
      before do
        get '/undefined/path'
      end

      include_examples :renders_home
    end
  end
end
