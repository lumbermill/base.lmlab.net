Rails.application.routes.draw do
  get 'users/index'

  resources :orders
  resources :products
  devise_for :users

  get 'pages/dashboard'
  root to: 'pages#root'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
