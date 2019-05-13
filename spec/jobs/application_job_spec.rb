# frozen_string_literal: true

describe ApplicationJob do
  it 'is loadable' do
    expect(ApplicationJob).not_to be(nil)
  end
end
