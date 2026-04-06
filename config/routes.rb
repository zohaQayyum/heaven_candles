Rails.application.routes.draw do
  devise_for :users
  
  root "home#index"
  
  resources :products, only: [:index, :show]
  
  get "up" => "rails/health#show", as: :rails_health_check

  resource :cart, only: [:show], controller: 'cart'
  post 'cart/add/:variant_id', to: 'cart#add', as: :add_to_cart
  delete 'cart/remove/:variant_id', to: 'cart#remove', as: :remove_from_cart
  patch 'cart/increment/:variant_id', to: 'cart#increment', as: :increment_cart
  patch 'cart/decrement/:variant_id', to: 'cart#decrement', as: :decrement_cart

  namespace :admin do
    resources :products do
      resources :variants, controller: 'product_variants'
    end
    resources :categories
  end
end
