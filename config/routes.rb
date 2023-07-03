Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: 'pages#landing'
  get 'pages/home', to: 'pages#home'
  get 'pages/draw', to: 'pages#draw'
  get 'matches/new'
  get 'matches/create'
  get 'matches/:id/edit_points', to: 'matches#edit_points', as: 'edit_points_match'
  resources :matches do
    member do
      get 'edit_points'
      patch 'update_points'
    end
  end
end
