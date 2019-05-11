# frozen_string_literal: true

class PlaylistElementSerializer < ApplicationSerializer
  attributes :id,
             :name,
             :artist_name,
             :album_name,
             :album_id,
             :duration

  def id
    object.track_id
  end
end
