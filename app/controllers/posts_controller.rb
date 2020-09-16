class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(processed_params)
    if @post.save
      redirect_to posts_path, notice:'投稿が追加されました。'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(processed_params)
      redirect_to posts_path, notice:'投稿が更新されました。'
    else
      rendwer :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice:'投稿を削除しました。'
  end

  private
  def post_params
    params.require(:post).permit(:title, :picture, :music, :music_type)
  end

  def processed_params
      int_param = post_params
      int_param[:music_type] = int_param[:music_type].to_i
      int_param
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
