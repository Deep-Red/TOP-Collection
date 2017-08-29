Rails.application.routes.draw do

  root 'static_pages#home'
  devise_for :users, :controllers => { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations'}
#  devise_scope :user do
#    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
#  end

  resources :users do
    resources :friends
  end
  resources :posts do
    member do
      post 'like'
    end
    resources :comments do
      member do
        post 'like'
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
