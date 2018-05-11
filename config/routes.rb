require 'active_subdomain'

Rails.application.routes.draw do
  constraints(ActiveSubdomain) do
    root to: 'shop#show'
  end

  root to: 'shop#index'
end
