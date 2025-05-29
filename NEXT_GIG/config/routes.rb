Rails.application.routes.draw do
  devise_for :users

  root 'pages#home'  # Assuming you have a home action in your PagesController
end