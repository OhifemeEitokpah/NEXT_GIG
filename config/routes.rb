Rails.application.routes.draw do
  get 'notifications/mark_all_read'
  devise_for :users

  # Define health check route
  get "up" => "rails/health#show", as: :rails_health_check

  get "/dashboard" => "pages#dashboard"

  root "events#index"

  # Defines the root path route ("/")
  resources :events, only: [:index, :show, :new, :edit, :update] do
    resources :bookings, only: [:new, :create, :destroy]
  end

  resources :notifications, only: [] do
    collection do
      patch :mark_all_read
    end
  end
end
