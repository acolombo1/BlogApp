class Api::CommentsController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :null_session
  
 def jsoncreate
    @comment = Comment.new(text: params.require(:comment), author_id: current_user.id, post_id: params[:id])
    @comment.save

    render json: { result: 'Comment created successfully.' }
  end
end