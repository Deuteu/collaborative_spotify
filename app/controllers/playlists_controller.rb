# frozen_string_literal: true

class PlaylistsController < ApplicationController
  def index
    playlists = Playlist.all

    render status: :ok, json: playlists
  end

  def tracks
    return if require_playlist

    # Add a limit ?
    tracks = PlaylistElement.with_track(playlist.active_elements)

    render status: :ok, json: tracks
  end

  def add_track
    return if require_playlist
    return if require_track
    return if add_track_to_playlist

    render status: :created, json: @element
  end

  private

  def playlist
    @playlist ||= Playlist.find_by(id: params[:playlist_id])
  end

  def require_playlist
    render status: :not_found, json: {} unless playlist

    performed?
  end

  def require_track
    track_id = params[:track_id].presence
    unless track_id
      render status: :bad_request, json: {}
      return performed?
    end

    @track = RSpotify::Track.find(track_id)
    render status: :not_found, json: {} unless @track

    performed?
  end

  def add_track_to_playlist
    @element = playlist.elements.create(
      user: User.first, # TODO: Change
      spotify_id: @track.id
    )
    render status: :unprocessable_entity, json: {} unless @element.persisted?

    performed?
  end
end
