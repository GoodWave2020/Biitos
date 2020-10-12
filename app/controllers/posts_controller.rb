class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    if params[:q] != nil
      params[:q][:title_or_labels_name_cont_any] = params[:q][:title_or_labels_name_cont_any].split(/[\p{blank}\s]+/)
    end
    @q = Post.ransack(params[:q])
    @q.sorts = 'created_at desc' if @q.sorts.empty?
    @voice_posts = @q.result(distinct: true).where(music_type: 'Voice').includes(:user)
    @tune_posts = @q.result(distinct: true).where(music_type: 'Tune').includes(:user)
    @collabolated_posts = @q.result(distinct: true).where(music_type: 'Collabolated').includes(:user)
    if user_signed_in?
      @favorites = current_user.favorites
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    label_list = label_params[:label_list].split(',')
    if @post.save
      @post.save_labels(label_list)
      redirect_to posts_path, notice: t('controller.public.the_post_added')
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
    @label_list = @post.labels.pluck(:name).join(',')
  end

  def update
    label_list = label_params[:label_list].split(',')
    if @post.update(post_params)
      @post.save_labels(label_list)
      redirect_to posts_path, notice:t('controller.public.the_post_updated')
    else
      render :edit
    end
  end

  def destroy
    check_user(@post.user)
    @post.destroy
    redirect_to posts_path, notice:t('controller.public.the_post_deleted')
  end

  private
  def post_params
    params.require(:post).permit(:title, :picture, :music, :music_type, :genre)
  end

  def label_params
    params.require(:post).permit(:label_list)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
