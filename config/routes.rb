Rails.application.routes.draw do
  devise_for :users
  devise_scope :users do
    get  'users/admin_new' => 'users#admin_new'
    post 'users/admin_create' => 'users#admin_create'
  end

  get 'users/admin' => 'users#admin'

  resources :users, only: [:index, :show, :update, :destroy, :edit]
  resources :stocks, param: :sym
  resources :portfolio

  root 'portfolios#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # root "home#index"
end
