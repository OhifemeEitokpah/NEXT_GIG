class PagesController < ApplicationController
  def home
  end

  def dashboard

    @bookings_as_musician = current_user.bookings
    @bookings_as_organiser = current_user.booked_bookings

  end

  def index
    @resource = User.new
    @resource_name = :user
    @devise_mapping = Devise.mappings[:user]
  end

end
