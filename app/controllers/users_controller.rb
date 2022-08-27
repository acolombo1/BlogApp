class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find(params[:id])
    @current_user = current_user
  end
end
