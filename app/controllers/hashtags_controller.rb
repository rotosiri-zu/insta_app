class HashtagsController < ApplicationController
  def index
    @hashtags = Hashtag.all
  end

  def show
    @hashtag = Hashtag.find_by(hashname: params[:hashname])
    @posts = Kaminari.paginate_array(@hashtag.posts.reverse).page(params[:page]).per(POST_PER)
  end
end
