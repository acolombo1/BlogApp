class CommentsController < ApplicationController
  def new
    comment = Comment.new
    respond_to do |format|
      format.html { render :new, locals: { comment: } }
    end
  end

  def create
    comment = Comment.new(params.require(:comment).permit(:text))
    comment.author_id = current_user.id
    comment.post_id = params[:id]

    respond_to do |format|
      format.html do
        if comment.save
          flash[:success] = 'Comment created successfully'
          redirect_to "/users/#{current_user.id}/posts"
        else
          flash.now[:error] = 'Error: Comment could not be saved'
          render :new, locals: { comment: }, status: 422
        end
      end
    end
  end
end
