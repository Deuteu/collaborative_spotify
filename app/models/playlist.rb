# frozen_string_literal: true

class Playlist < ApplicationRecord
  validates_presence_of :name

  has_many :elements, class_name: 'PlaylistElement', inverse_of: :playlist
  has_many :active_elements, -> { active }, class_name: 'PlaylistElement', inverse_of: :playlist
end
