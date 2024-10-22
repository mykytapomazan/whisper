Rails.application.routes.draw do
  # User authentication
  devise_for :users

  # Health check route
  get 'health', to: 'rails/health#show', as: :health_check

  # Core routes
  root to: 'dashboard#index'
  resources :posts, only: [:create]
end
