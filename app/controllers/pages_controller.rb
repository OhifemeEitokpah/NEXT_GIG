class PagesController < ApplicationController
  def home
  end

  def dashboard
  end

  def index
    @resource = User.new
    @resource_name = :user
    @devise_mapping = Devise.mappings[:user]
  end

end
