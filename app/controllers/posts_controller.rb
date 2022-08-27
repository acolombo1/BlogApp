class PostsController < ApplicationController
  # before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(Arel.sql('created_at DESC'))
    @current_user = current_user
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: } }
    end
  end

  def create
    post = Post.new(params.require(:post).permit(:title, :text))
    post.comments_counter = 0
    post.likes_counter = 0
    post.author_id = current_user.id

    respond_to do |format|
      format.html do
        if post.save
          flash[:success] = 'Post created successfully'
          redirect_to "/users/#{current_user.id}/posts"
        else
          flash.now[:error] = 'Error: Post could not be saved'
          render :new, locals: { post: }, status: 422
        end
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post
    @post.destroy
    redirect_to(request.referer)
  end
end
