class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_notification_count

  def get_notification_count
    @notification_count = Notification.where(to_user_id:current_user.id, checked: false).count
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,        keys: [:name, :user_name, :website, :bio, :phone_number, :sex])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :user_name, :website, :bio, :phone_number, :sex])
  end
end
