class Api::PostsController < ApplicationController
  #before_action :authenticate_user!
  
  def index
    user = User.find(params[:user_id])
    posts = user.posts.order(Arel.sql('created_at DESC'))
    render json: { posts: }, status: :ok
  end
end