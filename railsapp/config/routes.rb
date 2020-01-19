Rails.application.routes.draw do
  get 'orders/checkout1'
  post 'orders/checkout2'
  get 'orders/n-in-cart'
  get 'orders/history'
  get 'orders/of-children', to: 'orders#index_of_children'
  get 'products/picture' # code=0000&suffix=main
  get 'tags/picture' # code=0000
  get 'messages/by-users', to: 'messages#index_by_users'

  resources :orders
  resources :products
  resources :tags
  resources :messages
  devise_for :users, controllers: {
      registrations: 'users/registrations'
  }

  get 'pages/dashboard'
  get 'pages/dashboard-count' => 'pages#dashboard_count'
  get 'pages/users'
  get 'pages/sign-in-as' => 'pages#sign_in_as', as: :sign_in_as
  root to: 'pages#root'

  get 'pos' => 'products#pos', as: :pos
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
