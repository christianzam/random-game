Rails.application.routes.draw do
  root to: 'pages#landing' # For non-authenticated users

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  namespace :api do
    namespace :v1 do
      resources :users
    end
  end

  resources :tournaments
  resources :player_game_results

  get 'pages/home', to: 'pages#home'
  get 'pages/draw', to: 'pages#draw'
  post 'pages/run_draw', to: 'pages#run_draw'

  get 'games/new'
  get 'games/create'
  get 'games/:id/edit_points', to:'games#edit_points', as: 'edit_points_match'

  resources :games do
    member do
      get 'edit_points'
      patch 'update_points'
    end
  end
end
