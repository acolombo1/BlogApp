class Api::PostsController < ApplicationController
  before_action :authenticate_user!
  
  def list
    @posts = Post.where(author_id: params[:user_id])
    render json: @posts
  end

  def comments
    @comments = Comment.where(post_id: params[:id])
    render json: @comments
  end

end