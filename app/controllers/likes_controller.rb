class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    likes_author = Like.where(author_id: current_user.id)
    likes_post = Like.where(post_id: params[:id])

    likes = likes_author.merge(likes_post)

    return unless likes == [] && current_user.id != Post.find(params[:id]).author_id

    like = Like.new
    like.author_id = current_user.id
    like.post_id = params[:id]

    respond_to do |format|
      format.html do
        like.save
        redirect_to(request.referer)
      end
    end
  end
end
