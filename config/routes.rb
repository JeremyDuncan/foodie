Rails.application.routes.draw do
  devise_for :users
  resources :reviews
  resources :menu_items
  resources :users

  resources :restaurants do
    resources :images, only: [:index, :new, :create]
  end

  # Allow edit/update/destroy without nesting:
  resources :images, only: [:show, :edit, :update, :destroy]

  # root "home#index"
  root "home#root"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
