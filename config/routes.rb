require 'active_subdomain'

Rails.application.routes.draw do
  resources :shop, only: [:create, :show]

  constraints(ActiveSubdomain) do
    root to: 'shop#show'
  end

  root to: 'shop#index'

  match '/create', to: 'shop#new', as: 'new_shop',  via: [:get]
  match '/create', to: 'shop#create', as: 'create_shop',  via: [:post]
end
