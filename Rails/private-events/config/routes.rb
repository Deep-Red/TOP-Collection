Rails.application.routes.draw do

  get 'users/new'

  get 'users/create'

  get 'users/show'

  root  'static_pages#home'
  get   'static_pages/home'
  get   '/signup' => 'users#new'
  get   '/login'  => 'sessions#new'
  post  '/login'  => 'sessions#create'

  resources :sessions
  resources :users
  resources :events
  resources :invitations


end
