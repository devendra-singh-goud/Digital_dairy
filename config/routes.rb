Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users
  
  # Posts resources (index, show, new, edit, create, update, destroy)
  resources :posts do
    resources :comments, only: [:create]
  end
  
  # Health check route for uptime monitoring
  get "up" => "rails/health#show", as: :rails_health_check
  
  # PWA routes for service worker and manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Root path (change to whatever you want, defaulting to posts#index)
  root "posts#index"
end
