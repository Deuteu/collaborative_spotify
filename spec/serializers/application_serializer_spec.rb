# frozen_string_literal: true

describe ApplicationSerializer do
  describe 'attributes' do
    it 'returns only not nil attributes' do
      TestSerializer = Class.new(ApplicationSerializer) do
        attributes :id, :first_name, :last_name
      end

      object = User.new(id: nil, first_name: false, last_name: '')
      serializer = TestSerializer.new(object)

      expect(serializer.attributes).not_to have_key(:id)
      expect(serializer.attributes).to have_key(:first_name)
      expect(serializer.attributes).to have_key(:last_name)
    end
  end
end
