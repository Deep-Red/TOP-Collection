Rails.application.routes.draw do

  resources :photos, only:[:index, :show, :new, :create, :destroy]
  root 'photos#index'

end
