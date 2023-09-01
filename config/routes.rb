Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
 end
  root "cars#index"
  resource :contact_page, only: [:show]
  resource :about_page, only: [:show]
  resources :cars, only: [:index, :show]
  resources :orders

  get '/cars/category/:id', to: 'cars#by_category', as: :cars_by_category
  get '/cart', to: 'carts#show', as: 'cart'
  get '/cart/add_item/:car_id', to: 'carts#add_item', as: 'add_item'
  get '/cart/remove_item/:car_id', to: 'carts#remove_item', as: 'remove_item'
  get '/cart/delete_item/:car_id', to: 'carts#delete_item', as: 'delete_item'
  post '/payment/:order_id', to: 'payments#create', as: :order_payment
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
