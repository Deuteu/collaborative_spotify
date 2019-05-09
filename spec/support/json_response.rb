# frozen_string_literal: true

module JsonResponse
  class << self
    def included(base)
      return unless base.respond_to?(:shared_examples)

      shared_examples_return(base, :ok)
      shared_examples_return(base, :created)
      shared_examples_return(base, :bad_request)
      shared_examples_return(base, :not_found)
      shared_examples_return(base, :unprocessable_entity)

      base.shared_examples :renders_json do
        it 'renders a json response' do
          expect(response.content_type).to eq('application/json')
        end
      end
    end

    private

    def shared_examples_return(base, status)
      base.shared_examples :"returns_#{status}" do
        it "returns a #{status}" do
          expect(response).to have_http_status(status)
        end
      end
    end
  end

  def parsed_response
    JSON.parse(response.body)
  end
end
