class DirectMessageSpacesController < ApplicationController
  before_action :authenticate_user!
  def create
    current_user_dm_spaces = DirectMessageSpaceUser.where(user_id: current_user.id).map(&:direct_message_space)
    dm_space = DirectMessageSpaceUser.where(direct_message_space: current_user_dm_spaces, user_id: params[:user_id]).
      map(&:direct_message_space).first
    if dm_space.blank?
      dm_space = DirectMessageSpace.create
      DirectMessageSpaceUser.create(direct_message_space: dm_space, user_id: current_user.id)
      DirectMessageSpaceUser.create(direct_message_space: dm_space, user_id: params[:user_id])
    end
    redirect_to action: :show, id: dm_space.id
  end

  def show
    dm_space = DirectMessageSpace.find_by(id: params[:id])
    @dm_space_user = dm_space.direct_message_space_users.
      where.not(user_id: current_user.id).first.user
    @direct_message = current_user.direct_messages.build
    @direct_message.build_notification
    @direct_messages = DirectMessage.includes(:user).where(direct_message_space: dm_space).order(:created_at)
    @direct_messages.where.not(user_id: current_user.id).update_all(checked: true)
  end
end
