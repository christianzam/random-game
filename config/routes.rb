Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: 'pages#landing'
  get 'pages/home', to: 'pages#home'
  resources :gifts
  resources :members
  resources :groups
  get 'draws/:id', to: 'draws#show'
  post 'draws', to: 'draws#update'
end
