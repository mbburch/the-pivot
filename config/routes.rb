Rails.application.routes.draw do
  root to: "auctions#index"

  resources :items, only: [:index, :show]
  resources :categories, only: [:show]
  resources :bids, only: [:new, :create]
  resources :orders, only: [:new, :create, :show]
  resources :auctions, only: [:index]
  resources :stores, only: [:index, :show]


  post "/cart_items", to: "cart_items#create"
  get "/cart", to: "cart_items#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/dashboard", to: "users#show"
  get "/edit", to: "users#edit"
  put "/edit", to: "users#update"
  get "/register", to: "users#new"
  post "/register", to: "users#create"


  namespace :admin do
    resources :items, only: [:new, :create, :edit, :update]
    resources :orders, only: [:update]
    get "/dashboard", to: "admins#show"
  end

  namespace :seller, path: ':seller', as: :seller do
    get "/dashboard", to: "sellers#show"
    get "/:store/auctions", to: "auctions#index"
    resources :auctions, only: [:new, :create]
    resources :items, only: [:new, :create, :edit, :update]
  end

  namespace :stores, path: ':store', as: :store do
    resources :auctions, only: [:index, :show]
  end
end
