class CommentsController < ApplicationController
  before_action :authenticate_user_and_flash
  before_action :set_post, only: [:create, :edit, :update]
  def create
    @comment = @post.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        @post.create_notification_comment!(current_user, @comment.id)
        flash.now[:notice] = t('views.public.posting_succeeded')
        format.js { render :index }
      else
        format.html { redirect_to post_path(@post), notice: t('views.public.posting_failed') }
      end
    end
  end
  def edit
    @comment = @post.comments.find(params[:id])
    respond_to do |format|
      flash.now[:notice] = t('views.public.now_editting')
      format.js { render :edit }
    end
  end
  def update
    @comment = @post.comments.find(params[:id])
      respond_to do |format|
        if @comment.update(comment_params)
          flash.now[:notice] = t('views.public.editting_succeeded')
          format.js { render :index }
        else
          flash.now[:notice] = t('views.public.editting_failed')
          format.js { render :edit_error }
        end
      end
  end
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      flash.now[:notice] = t('views.public.posting_destroyed')
      format.js { render :index }
    end
  end
  private
  def comment_params
    params.require(:comment).permit(:post_id, :user_id, :body)
  end
  def set_post
    @post = Post.find(params[:post_id])
  end
end
