Rails.application.routes.draw do
  root to: "auctions#index"
  resources :items, only: [:index, :show]
  resources :categories, only: [:show]

  post "/cart_items", to: "cart_items#create"
  get "/cart", to: "cart_items#index"
  put "/cart_items/:id", to: "cart_items#update"
  delete "/cart_items/:id", to: "cart_items#destroy"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/dashboard", to: "users#show"
  get "/register", to: "users#new"
  post "/register", to: "users#create"


  namespace :admin do
    resources :items, only: [:new, :create, :edit, :update]
    resources :orders, only: [:update]
    get "/dashboard", to: "admins#show"
    get "/edit", to: "admins#edit"
    put "/edit", to: "admins#update"
  end

  namespace :seller, path: ':seller', as: :seller do
    get "/dashboard", to: "sellers#show"
    get "/:slug/auctions", to: "auctions#index"
    resources :items, only: [:show]
  end

  namespace :stores, path: ':store', as: :store do
    resources :auctions, only: [:index, :show]
  end

  resources :bids, only: [:new, :create, :update]
  resources :orders, only: [:new, :create, :show]
  resources :stores, only: [:index, :new, :edit, :update]
  resources :auctions, only: [:index]
end
