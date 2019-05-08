# frozen_string_literal: true

describe PlaylistElement do
  it 'must have a spotify id' do
    element = FactoryBot.build(:playlist_element, spotify_id: nil)

    expect(element).not_to be_valid
  end

  it 'must belong to a user' do
    element = FactoryBot.build(:playlist_element, user: nil)

    expect(element).not_to be_valid
  end

  it 'must be in a playlist' do
    element = FactoryBot.build(:playlist_element, playlist: nil)

    expect(element).not_to be_valid
  end

  context 'when removed date is set' do
    it 'cannot change removed date' do
      element = FactoryBot.create(:playlist_element, :removed)

      expect { element.update(removed_at: Time.current) }.
        not_to(change { element.reload.removed_at })
    end
  end

  describe '#remove' do
    let(:element) { FactoryBot.create(:playlist_element, removed_at: nil) }

    it 'sets the removed date' do
      element.remove

      expect(element.removed_at).not_to be_nil
    end

    it 'marks the element as removed' do
      element.remove

      expect(element.removed?).to be(true)
    end

    it 'marks the element as not active' do
      element.remove

      expect(element.active?).to be(false)
    end
  end
end
