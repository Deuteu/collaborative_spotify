# frozen_string_literal: true

describe User do
  it 'must have a first name' do
    user = FactoryBot.build(:user, first_name: nil)

    expect(user).not_to be_valid
  end

  it 'must have a last name' do
    user = FactoryBot.build(:user, last_name: nil)

    expect(user).not_to be_valid
  end
end
