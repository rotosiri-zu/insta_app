class DirectMessagesController < ApplicationController
  def create
    @direct_message = DirectMessage.create(direct_message_params)
    redirect_to direct_message_space_path(id: params[:direct_message][:direct_message_space_id])
  end

  private
    def direct_message_params
      params.require(:direct_message).permit(:user_id, :direct_message_space_id, :message)
    end
end
