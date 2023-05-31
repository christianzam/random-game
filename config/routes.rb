Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: 'pages#landing'
  get 'pages/home', to: 'pages#home'
  resources :player_stats
  resources :match_stats
  resources :weekly_stats
  get 'pages/draw', to: 'pages#draw'
end
