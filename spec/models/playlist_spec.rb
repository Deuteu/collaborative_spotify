# frozen_string_literal: true

describe Playlist do
  it 'must have a name' do
    playlist = FactoryBot.build(:playlist, name: nil)

    expect(playlist).not_to be_valid
  end
end
