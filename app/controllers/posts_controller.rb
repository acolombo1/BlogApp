class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(Arel.sql('created_at DESC'))
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end
end
