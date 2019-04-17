class NotificationsController < ApplicationController
  def index
    @informations = Information.where(to_user_id: current_user.id)
  end
end
