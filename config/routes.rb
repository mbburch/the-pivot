Rails.application.routes.draw do
  root to: "items#index"
  resources :items, only: [:index, :show]
  resources :categories, only: [:show]
  post "/cart_items", to: "cart_items#create"
  get "/cart", to: "cart_items#index"
  put "/cart_items/:id", to: "cart_items#update"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/dashboard", to: "users#show"
  get "/edit", to: "users#edit"
  put "/edit", to: "users#update"
  delete "/logout", to: "sessions#destroy"
  get "/register", to: "users#new"
  post "/register", to: "users#create"
  delete "/cart_items/:id", to: "cart_items#destroy"

  namespace :admin do
    resources :items, only: [:index, :new, :create, :edit, :update]
    resources :orders, only: [:update]
    get "/dashboard", to: "admins#show"
    get "/edit", to: "admins#edit"
    put "/edit", to: "admins#update"
  end

  namespace :seller, path: ':seller', as: :seller do
    get "/dashboard", to: "sellers#show"
  end

  namespace :stores, path: ':store', as: :store do
    resources :items, only: [:index]
  end

  resources :bids, only: [:new, :create]
  resources :orders, only: [:new, :create, :show]
  resources :stores, only: [:index, :new, :edit, :update]
end
