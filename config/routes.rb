Rails.application.routes.draw do
  resources :stocks
  devise_for :users

  resources :transactions

  root 'transactions#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # root "home#index"
end
