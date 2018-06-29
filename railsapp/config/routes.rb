Rails.application.routes.draw do
  get 'orders/checkout'
  get 'products/picture' # code=0000&suffix=main

  resources :orders
  resources :products
  resources :tags
  devise_for :users

  get 'pages/about'
  get 'pages/dashboard'
  get 'pages/users'
  root to: 'pages#root'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
