class UsersController < ApplicationController
  # before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @current_user = current_user
  end

  def api_token
    @user = User.find(params[:id])
    respond_to do |format|
      format.json { render json: @user.api_token, status: :ok }
      format.html
    end
  end
end
