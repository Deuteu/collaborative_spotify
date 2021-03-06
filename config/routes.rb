# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'views#home'

  get 'spotify/search', to: 'spotify#search'

  scope '/api' do
    resources :tracks, param: :track_id, only: [] do
      collection do
        get 'search'
      end
    end

    resources :playlists, param: :playlist_id, only: [:index] do
      member do
        get 'tracks'
        post 'tracks', action: :add_track
      end
    end
  end

  get '*path' => 'views#home', constraints: {path: %r{(?!api/).*}}
end
