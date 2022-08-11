Rails.application.routes.draw do
  devise_for :users
  devise_scope :users do
    get  'users/admin_new' => 'users#admin_new'
    post 'users/admin_create' => 'users#admin_create'
  end

  # get 'stock/:id/buy' => 'stocks#buy_stock', as: 'stock_buy'
  get 'users/admin' => 'users#admin'
  get 'stocks' => 'stocks#index'
  get 'transactions/buy' => 'transactions#buy'
  get 'transactions/:id/sell' => 'transactions#sell', as: "transactions_sell"
  resources :transactions, only: [:create, :destroy]
  root 'pages#home'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # root "home#index"
end
