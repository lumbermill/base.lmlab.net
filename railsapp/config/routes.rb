Rails.application.routes.draw do
  get 'orders/checkout1'
  get 'orders/checkout2'
  get 'orders/n-in-cart'
  get 'orders/history'
  get 'products/picture' # code=0000&suffix=main
  get 'tags/picture' # code=0000

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
