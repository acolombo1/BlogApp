class Api::CommentsController < ApplicationController
  #before_action :authenticate_user!

  def index
    comments = Comment.where(post_id: params[:id])
    render json: { comments: }, status: :ok
  end

  def create
    input_values = params.require(:comment).permit(:text)
    comment = Comment.new(text: input_values[:text], author_id: current_user.id, post_id: params[:post_id])
  
    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end
end