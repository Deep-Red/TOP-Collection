Rails.application.routes.draw do

  get 'invitations/only'

  get 'invitations/new'

  get 'invitations/create'

  get 'events/new'

  get 'events/create'

  get 'events/show'

  get 'events/index'

  get 'users/new'

  get 'users/create'

  get 'users/show'

  root  'static_pages#home'
  get   'static_pages/home'
  get   '/signup' => 'users#new'
  get   '/login'  => 'sessions#new'
  post  '/login'  => 'sessions#create'
  get   '/logout' => 'sessions#destroy'

  resources :sessions
  resources :users
  resources :events
  resources :invitations


end
