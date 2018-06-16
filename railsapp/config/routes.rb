Rails.application.routes.draw do
  resources :orders
  resources :products
  devise_for :users

  get 'orders/checkout'
  get 'pages/dashboard'
  get 'pages/users'
  root to: 'pages#root'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
