# frozen_string_literal: true

describe ApplicationController do
  describe 'rescue' do
    def parsed_response
      JSON.parse(response.body)
    end

    context 'when an action throw a RSpotify::MissingAuthentication exception' do
      controller(ApplicationController) do
        def new_action
          raise RSpotify::MissingAuthentication
        end
      end

      before do
        routes.draw { get 'new_action' => 'anonymous#new_action' }
      end

      it 'catches the error' do
        expect { get :new_action }.not_to raise_error
      end

      it 'renders an error json' do
        get :new_action

        expect(response.content_type).to eq('application/json')
        expect { parsed_response }.not_to raise_error
        expect(parsed_response.key?('error')).to be_truthy
      end

      it 'returns a bad_gateway' do
        get :new_action

        expect(response).to have_http_status(:bad_gateway)
      end
    end

    context 'when an action throw a StandardError exception' do
      controller(ApplicationController) do
        def new_action
          raise StandardError
        end
      end

      before do
        routes.draw { get 'new_action' => 'anonymous#new_action' }
      end

      it 'catches the error' do
        expect { get :new_action }.not_to raise_error
      end

      it 'renders an error json' do
        get :new_action

        expect(response.content_type).to eq('application/json')
        expect { parsed_response }.not_to raise_error
        expect(parsed_response.key?('error')).to be_truthy
      end

      it 'returns a internal_server_error' do
        get :new_action

        expect(response).to have_http_status(:internal_server_error)
      end
    end
  end
end
