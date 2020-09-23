class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!
  def show
  end

  def following
  end

  def followers
  end

  def friend_index
    @users = current_user.followers & current_user.following
  end
  private
  def set_user
    @user = User.find(params[:id])
  end
end
