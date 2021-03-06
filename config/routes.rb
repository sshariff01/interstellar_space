require 'active_subdomain'
require 'inactive_subdomain'

Rails.application.routes.draw do

  constraints(ActiveSubdomain) do
    match '/products/purchase/:id', to: 'products#purchase', via: [:get]
    match '/products/purchase', to: 'products#purchase', via: [:post]

    root to: 'shops#show', as: 'merchant_root'

    resources :shops, only: [:show]
  end

  constraints(InactiveSubdomain) do
    resources :shops, only: [:create, :new]

    root to: 'merchants#index', as: 'site_root'

    match '/merchants/dashboard', to: 'merchants#dashboard', as: 'merchant_dashboard', via: [:get]
    match '/merchants/signup', to: 'merchants#new', as: 'signup_merchant', via: [:get]
    match '/merchants/create', to: 'merchants#create', as: 'register_merchant', via: [:post]

    match '/merchants/login', to: 'sessions#new', as: 'login_merchant', via: [:get]
    match '/merchants/login', to: 'sessions#create', as: 'create_merchant_session', via: [:post]
    match '/merchants/logout', to: 'sessions#destroy', via: [:get]
  end

end
