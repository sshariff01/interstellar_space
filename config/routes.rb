require 'active_subdomain'

Rails.application.routes.draw do
  resources :shop, only: [:create, :show]

  constraints(ActiveSubdomain) do
    root to: 'shop#show'
  end

  root to: 'shop#index'

  match '/create', to: 'shop#new', as: 'new_shop',  via: [:get]
  match '/create', to: 'shop#create', as: 'create_shop',  via: [:post]

  match '/merchant/signup', to: 'merchant#new', as: 'signup_merchant', via: [:get]
  match '/merchant/create', to: 'merchant#create', as: 'register_merchant', via: [:post]

  match '/merchant/login', to: 'sessions#new', as: 'login_merchant', via: [:get]
  match '/merchant/login', to: 'sessions#create', as: 'create_merchant_session', via: [:post]
  match '/merchant/login', to: 'sessions#destroy', via: [:get]
end
