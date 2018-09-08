Rails.application.routes.draw do
  get 'orders/checkout1'
  get 'orders/checkout2'
  get 'orders/n-in-cart'
  get 'orders/history'
  get 'orders/of-children', to: 'orders#index_of_children'
  get 'products/picture' # code=0000&suffix=main
  get 'tags/picture' # code=0000

  resources :orders
  resources :products
  resources :tags
  devise_for :users

  get 'pages/dashboard'
  get 'pages/users'
  get 'pages/sign-in-as' => 'pages#sign_in_as', as: :sign_in_as
  root to: 'pages#root'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
