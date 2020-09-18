class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @voice_posts = Post.all.where(music_type: 'Voice').includes(:user)
    @tune_posts = Post.all.where(music_type: 'Tune').includes(:user)
    @collabolated_posts = Post.all.where(music_type: 'Collabolated').includes(:user)
    if user_signed_in?
      @favorites = current_user.favorites
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(processed_params)
    if @post.save
      redirect_to posts_path, notice:'投稿が追加されました。'
    else
      render :new
    end
  end

  def show
    @comments = @post.comments
    @comment = @post.comments.build
    @favorites = current_user.favorites
  end

  def edit
    check_user(@post.user)
  end

  def update
    if @post.update(processed_params)
      redirect_to posts_path, notice:'投稿が更新されました。'
    else
      rendwer :edit
    end
  end

  def destroy
    check_user(@post.user)
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
