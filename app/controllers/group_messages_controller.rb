class GroupMessagesController < ApplicationController
  before_action :set_group
  def index
    @users = email_search(params[:search])
    @group_message = GroupMessage.new
    @group_messages = @group.group_messages.includes(:user)
  end

  def create
    @group_message = @group.group_messages.new(group_message_params)
    if @group_message.save
      redirect_to group_group_messages_path(@group), notice: 'メッセージが送信されました'
    else
      @group_messages = @group.group_messages.includes(:user)
      flash.now[:notice] = 'メッセージを入力してください'
      render :index
    end
  end

  def group_message_params
    params.require(:group_message).permit(:body, :group_music).merge(user_id: current_user.id)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
