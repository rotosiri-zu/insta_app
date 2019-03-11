class PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @posts = Post.limit(10).includes(:photos, :user).order('created_at DESC')
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if params[:images]
      params[:images].each do |img|
        @post.save
        @post.photos.create(image: img)
        redirect_to root_path
        flash[:notice] = "投稿が保存されました"
      end
    else
      redirect_to root_path
      flash[:alert] = "投稿に失敗しました"
    end
  end

  private
    def post_params
      params.require(:post).permit(:caption).merge(user_id: current_user.id)
    end
end
