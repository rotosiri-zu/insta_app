class DirectMessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @direct_message = DirectMessage.new(direct_message_params)
    @dm_space = DirectMessageSpace.find_by(id: @direct_message.direct_message_space_id)
    @direct_messages = DirectMessage.includes(:user).where(direct_message_space: @dm_space).order(:created_at)
    if @direct_message.save
      respond_to do |format|
        format.html { redirect_to @dm_space }
        format.js
      end
    else
      flash[:alert] = "メッセージに失敗しました"
    end
  end

  private

  def direct_message_params
    params.require(:direct_message).
      permit(:user_id, :direct_message_space_id, :message, notification_attributes: [:id, :to_user_id, :from_user_id])
  end
end
