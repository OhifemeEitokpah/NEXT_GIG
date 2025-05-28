Rails.application.routes.draw do
  devise_for :users

  # Define health check route
  get "up" => "rails/health#show", as: :rails_health_check

  get "/dashboard" => "pages#dashboard"

  root "events#index"

  # Defines the root path route ("/")
  resources :events, only: [:index, :show, :new, :edit, :update] do
    resources :bookings, only: [:create]

  end
end
