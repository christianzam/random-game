Rails.application.routes.draw do
  resources :members
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: 'pages#landing'
  get 'pages/home', to: 'pages#home'
  # resources :gifts
end
