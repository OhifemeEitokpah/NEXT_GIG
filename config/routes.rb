Rails.application.routes.draw do
  devise_for :users

  # Define health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Define root route
  root "events#index"

  # Define route for showing a specific event
  get '/events/:id', to: 'events#show', as: 'event'

  # Define nested resources for bookings within events
  resources :events do
    resources :bookings, only: [:create, :new]
  end
end
