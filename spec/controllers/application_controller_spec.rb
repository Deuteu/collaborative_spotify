# frozen_string_literal: true

describe ApplicationController do
  describe 'rescue' do
    context 'when an action throw a RSpotify::MissingAuthentication exception' do
      controller(ApplicationController) do
        def new_action
          raise RSpotify::MissingAuthentication
        end
      end

      before(:each) do
        routes.draw { get 'new_action' => 'anonymous#new_action' }
      end

      it 'catches the error' do
        expect { get :new_action }.not_to raise_error
      end

      let(:parsed_body) { JSON.parse(response.body) }

      it 'renders an error json' do
        get :new_action
        expect(response.content_type).to eq('application/json')
        expect { parsed_body }.not_to raise_error
        expect(parsed_body.key?('error')).to be_truthy
      end

      it 'returns a 502 status' do
        get :new_action
        expect(response).to have_http_status(:bad_gateway)
      end
    end
  end
end
