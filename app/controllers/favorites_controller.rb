class FavoritesController < ApplicationController
  before_action :set_post, only: [:create, :destroy]
  before_action :set_favorites, only: [:create, :destroy]
  def create
    favorite = current_user.favorites.create(post_id: params[:post_id])
    @post.create_notification_like!(current_user)
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end
  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
  end
  private
  def set_post
    @post = Post.find_by(id: params[:post_id])
  end
  def set_favorites
    @favorites = current_user.favorites
  end
end
