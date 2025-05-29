class PagesController < ApplicationController
  def home
  end

  def dashboard

    @bookings = current_user.bookings

  end

  def index
    @resource = User.new
    @resource_name = :user
    @devise_mapping = Devise.mappings[:user]
  end

end
