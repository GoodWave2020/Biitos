class DmMessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end
  def index
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
    @dm_message = @conversation.dm_messages.build(dm_message_params)
    if @dm_message.save
      redirect_to conversation_dm_messages_path(@conversation)
    else
      render 'index'
    end
  end
  private
  def dm_message_params
    params.require(:dm_message).permit(:body, :user_id)
  end
end
