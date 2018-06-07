require 'active_subdomain'
require 'inactive_subdomain'

Rails.application.routes.draw do

  constraints(ActiveSubdomain) do
    root to: 'shop#show', as: 'merchant_root'

    resources :shop, only: [:create, :show, :new]
  end

  constraints(InactiveSubdomain) do
    root to: 'merchant#index', as: 'site_root'

    match '/merchant/signup', to: 'merchant#new', as: 'signup_merchant', via: [:get]
    match '/merchant/create', to: 'merchant#create', as: 'register_merchant', via: [:post]

    match '/merchant/login', to: 'sessions#new', as: 'login_merchant', via: [:get]
    match '/merchant/login', to: 'sessions#create', as: 'create_merchant_session', via: [:post]
    match '/merchant/logout', to: 'sessions#destroy', via: [:get]

    resources :merchant, only: [:create, :show, :new]
  end

end
