require 'active_subdomain'

Rails.application.routes.draw do
  resources :shop, only: [:create, :show, :new]
  resources :merchant, only: [:create, :new]

  constraints(ActiveSubdomain) do
    root to: 'shop#show', as: 'merchant_root'
  end

  root to: 'merchant#index', as: 'site_root'

  match '/merchant/signup', to: 'merchant#new', as: 'signup_merchant', via: [:get]
  match '/merchant/create', to: 'merchant#create', as: 'register_merchant', via: [:post]

  match '/merchant/login', to: 'sessions#new', as: 'login_merchant', via: [:get]
  match '/merchant/login', to: 'sessions#create', as: 'create_merchant_session', via: [:post]
  match '/merchant/logout', to: 'sessions#destroy', via: [:get]
end
