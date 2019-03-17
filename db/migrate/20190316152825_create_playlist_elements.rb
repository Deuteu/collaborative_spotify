# frozen_string_literal: true

class CreatePlaylistElements < ActiveRecord::Migration[5.2]
  def change
    create_table :playlist_elements do |t|
      t.integer :playlist_id, null: false
      t.integer :user_id, null: false
      t.string :spotify_id, null: false

      t.datetime :removed_at

      t.timestamps

      t.index :spotify_id
      t.index :playlist_id
      t.index %i[playlist_id spotify_id user_id], unique: true, name: :unique_index_elements_on_playlist_id_and_user_id
    end
  end
end
