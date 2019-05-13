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

  describe 'any undefined path' do
    before do
      get '/undefined/path'
    end

    include_examples :renders_home
  end
end
