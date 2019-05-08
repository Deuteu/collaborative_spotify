# frozen_string_literal: true

class Playlist < ApplicationRecord
  validates :name, presence: true

  with_options dependent: :destroy, inverse_of: :playlist do
    has_many :elements, class_name: 'PlaylistElement'
    has_many :active_elements, -> { active }, class_name: 'PlaylistElement'
  end
end
