class UsersController < ApplicationController
  before_action :set_user
  # before_action :authenticate_user!
  def show
    @favorites = current_user.favorites
  end

  def following
  end

  def followers
  end

  def friend_index
    @users = current_user.followers & current_user.following
  end

  def favorites_index
    @favorites = current_user.favorites
  end
  private
  def set_user
    @user = User.find(params[:id])
  end
end
