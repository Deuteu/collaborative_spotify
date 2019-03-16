# frozen_string_literal: true

class Playlist < ApplicationRecord
  validates_presence_of :name
end
