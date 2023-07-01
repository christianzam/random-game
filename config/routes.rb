Rails.application.routes.draw do
  get 'matches/new'
  get 'matches/create'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: 'pages#landing'
  get 'pages/home', to: 'pages#home'
  resources :matches, only: [:new, :create]
  get 'pages/draw', to: 'pages#draw'
end
