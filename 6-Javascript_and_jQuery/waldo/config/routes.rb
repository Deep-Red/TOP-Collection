Rails.application.routes.draw do
  root 'static_pages#home'
  get 'checkItem' => 'static_pages#checkItem'
  get 'enter_score' => 'static_pages#enter_score'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
