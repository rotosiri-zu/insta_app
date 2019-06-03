class UsersController < ApplicationController
  def index
    @users = User.search(params[:search])
  end

  def show
    @user = User.find(params[:id])
    unless current_user == @user
      foot_stamp = FootStamp.find_by(to_user_id: @user.id, from_user_id: current_user.id)
      if foot_stamp
        foot_stamp.touch
        foot_stamp.checked = false
      else
        FootStamp.create(to_user_id: @user.id, from_user_id: current_user.id)
      end
    end
  end

  def following
    @user = User.find(params[:id])
  end

  def followers
    @user = User.find(params[:id])
  end

  def likes
    @user = User.find(params[:id])
    @posts = Post.find(Like.where(user_id: @user.id).pluck(:post_id))
  end

  def liked
    @user = User.includes(posts: [:likes, :photos]).find(params[:id])
    @posts =@user.posts.select{|post| post.likes != []}
  end

  def notifications
    @notifications = Notification.where(to_user_id: current_user.id).order('created_at DESC')
  end

  def notification_check
    Notification.where(to_user_id: current_user.id, checked: false).update_all(checked: true)
    redirect_to notifications_user_path(current_user)
  end

  def dm
    current_user_dm_spaces = DirectMessageSpaceUser.where(user_id: current_user.id).map(&:direct_message_space)
    @dm_spaces = DirectMessageSpaceUser.where(direct_message_space: current_user_dm_spaces).where.not(user_id: current_user.id).map(&:direct_message_space)
    dm_users_id = DirectMessageSpaceUser.where(direct_message_space: @dm_spaces).where.not(user_id: current_user.id).map(&:user_id)
    @dm_users = User.where(id: dm_users_id)
    @dm_unchecked_counts = []
    @dm_spaces.zip(@dm_users).each do |dm_space, dm_user|
      @dm_unchecked_counts << DirectMessage.where(direct_message_space_id: dm_space.id, user_id: dm_user.id, checked: false).count
    end
  end

  def foot_stamps
    @foot_stamps = FootStamp.where(to_user_id: current_user.id).order("updated_at DESC")
    FootStamp.where(to_user_id: current_user.id, checked: false).update_all(checked: true)
  end
end
