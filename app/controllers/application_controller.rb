class ApplicationController < ActionController::Base
  helper_method :resource_name, :resource, :devise_mapping
  # before_action :authenticate_user!
  before_action :load_notifications

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    Devise.mappings[:user]
  end

  private

  def load_notifications
    return unless current_user
    @notifications = current_user.notifications.unread.order(created_at: :desc)
  end
end
