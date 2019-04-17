class UsersController < ApplicationController
  def index
    @users = User.search(params[:search])
  end

  def show
    @user = User.find(params[:id])
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
    @notifications = Notification.where(to_user_id: current_user.id)
  end
end
