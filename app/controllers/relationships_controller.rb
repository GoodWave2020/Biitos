class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    @user.create_notification_follow!(current_user)
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
  end
end
