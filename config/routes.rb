Rails.application.routes.draw do
  devise_for :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"

  resources :restaurants, only: [ :new, :create, :show, :edit, :update ] do
    get "search", on: :collection
    resources :tags, only: [:new, :create]
    resources :menus, only: [:new, :create]
  end
  resources :restaurant_schedules, only: [ :new, :create, :show, :edit, :update ]
  resources :dishes, only: [ :index, :new, :create, :show, :edit, :update, :destroy ] do
    post 'inactive', on: :member 
    post 'active', on: :member
    resources :dish_portions, only: [ :new, :create, :show ] do
      resources :dish_previous_prices, only: [ :create ]
    end
  end
  resources :beverages, only: [ :index, :new, :create, :show, :edit, :update, :destroy ] do
    post 'inactive', on: :member 
    post 'active', on: :member
    resources :beverage_portions, only: [ :new, :create, :show ] do 
      resources :beverage_previous_prices, only: [ :create ]
    end
  end
end
