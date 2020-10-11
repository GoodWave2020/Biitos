class DmMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end
  before_action :authenticate_user!

  def index
    check_friend(@conversation)
    @dm_messages = @conversation.dm_messages
    if @dm_messages.length > 10
      @over_ten = true
      @dm_dm_messages = DmMessage.where(id: @dm_messages[-10..-1].pluck(:id))
    end
    if params[:m]
      @over_ten = false
      @dm_messages = @conversation.dm_messages
    end
    if @dm_messages.last
      @dm_messages.where.not(user_id: current_user.id).update_all(read: true)
    end
    @dm_messages = @dm_messages.order(:created_at)
    @dm_message = @conversation.dm_messages.build
  end
  def create
    check_friend(@conversation)
    @dm_messages = @conversation.dm_messages
    @dm_message = @conversation.dm_messages.build(dm_message_params)
    ######
    if @conversation.sender_id == current_user.id
      visited_id = @conversation.recipient_id
    else
      visited_id = @conversation.sender_id
    end
    ######
    if @dm_message.save
      @conversation.save_notification_dm_message!(current_user, @dm_message.id, visited_id)
      redirect_to conversation_dm_messages_path(@conversation)
    else
      flash.now[:notice] = t('controller.public.please_fill_in_the_the_comment')
      redirect_to conversation_dm_messages_path, notice: t('controller.public.please_fill_in_the_the_comment')
    end
  end
  def download
    @dm_message = DmMessage.find(params[:id])
    data = open(URI.encode(@dm_message.file_url))
    send_data data.read, disposition: 'attachment',
              filename: "#{@dm_message.body}.mp3", type: @dm_message.content_type
  end
  private
  def dm_message_params
    params.require(:dm_message).permit(:body, :user_id, :collab_music)
  end
end
