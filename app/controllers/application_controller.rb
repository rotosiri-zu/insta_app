class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_notification_count
  before_action :get_dm_count

  def get_notification_count
    @notification_count = Notification.where(to_user_id:current_user.id, checked: false).count
  end

  def get_dm_count
    current_user_dm_spaces = DirectMessageSpaceUser.where(user_id: current_user.id).map(&:direct_message_space)
    @dm_spaces = DirectMessageSpaceUser.where(direct_message_space: current_user_dm_spaces).where.not(user_id: current_user.id).map(&:direct_message_space)
    dm_users_id = DirectMessageSpaceUser.where(direct_message_space: @dm_spaces).where.not(user_id: current_user.id).map(&:user_id)
    @dm_users = User.where(id: dm_users_id)
    @dm_count = 0
    @dm_spaces.zip(@dm_users).each do |dm_space, dm_user|
      @dm_count += DirectMessage.where(direct_message_space_id: dm_space.id, user_id: dm_user.id, checked: false).count
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,        keys: [:name, :user_name, :website, :bio, :phone_number, :sex])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :user_name, :website, :bio, :phone_number, :sex])
  end
end
