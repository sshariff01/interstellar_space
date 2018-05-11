require 'active_subdomain'

Rails.application.routes.draw do
  resources :shop, except: [:index, :show]

  constraints(ActiveSubdomain) do
    root to: 'shop#show'
  end

  root to: 'shop#index'
end
