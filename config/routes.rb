require "sidekiq/web"
Rails.application.routes.draw do
  get 'reviews/create'
  devise_for :users 
  mount Sidekiq::Web => "/sidekiq"
  
  root "home#index"
  
  resources :products, only: [:index, :show] do
    resources :reviews, only: [:create, :index]
  end

  resources :orders, only: [:index, :show, :new, :create] do
    collection do
      get :track
    end
  end
  
  get "up" => "rails/health#show", as: :rails_health_check

  resource :cart, only: [:show], controller: 'cart'
  post 'cart/add/:variant_id', to: 'cart#add', as: :add_to_cart
  delete 'cart/remove/:id', to: 'cart#remove', as: :remove_from_cart
  patch 'cart/increment/:id', to: 'cart#increment', as: :increment_cart
  patch 'cart/decrement/:id', to: 'cart#decrement', as: :decrement_cart
  post 'coupons/apply', to: 'coupons#apply', as: :apply_coupon

  namespace :admin do
    resources :reviews, only: [:index, :update, :show]
    resources :coupons
    resources :products do
      resources :variants, controller: 'product_variants'
      member do
        delete :remove_image
      end
    end
    resources :categories
    resources :orders, only: [:index, :show, :update]
  end
end
