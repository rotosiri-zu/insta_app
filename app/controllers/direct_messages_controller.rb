class DirectMessagesController < ApplicationController
  before_action :authenticate_user!
  def create
    @direct_message = DirectMessage.new(direct_message_params)
    if @direct_message.save
      Pusher.trigger('dm-channel','new-dm', {
              user_name: current_user.user_name,
              message: @direct_message.message
            })
    else
      flash[:alert] = "メッセージに失敗しました"
    end
    redirect_to direct_message_space_path(id: params[:direct_message][:direct_message_space_id])
  end

  private
    def direct_message_params
      params.require(:direct_message).permit(:user_id, :direct_message_space_id, :message, notification_attributes: [:id, :to_user_id, :from_user_id] )
    end
end
