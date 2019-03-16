# frozen_string_literal: true

class PlaylistElement < ApplicationRecord
  belongs_to :user
  belongs_to :playlist

  validates :spotify_id, presence: true, uniqueness: {scope: %i[playlist user]}
  validates :user, presence: true
  validates :playlist, presence: true

  before_save :prevent_double_remove

  scope :active, -> { where(removed_at: nil) }
  scope :removed, -> { where.not(removed_at: nil) }

  def remove
    update(removed_at: Time.current)
  end

  def removed?
    removed_at.present?
  end

  def active?
    !removed?
  end

  def track
    @track ||= RSpotify::Track.find(spotify_id)
  end

  def track_loaded?
    !@track.nil?
  end

  def load_track(track)
    @track = track if track.is_a?(RSpotify::Track)
  end

  def duration
    return 0 unless track

    (track.duration_ms / 1000.0).ceil
  end

  private

  def prevent_double_remove
    clear_attribute_changes([:removed_at]) if removed_at_changed? && !removed_at_was.nil?
  end
end
