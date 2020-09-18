class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.create(post_id: params[:post_id])
    redirect_to posts_path, notice: "#{favorite.post.user.name}さんのブログをお気に入り登録しました"
  end
  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to posts_path, notice: "#{favorite.post.user.name}さんのブログをお気に入り解除しました"
  end
end
