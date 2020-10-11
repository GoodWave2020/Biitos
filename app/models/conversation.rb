class Conversation < ApplicationRecord
  has_many :notifications, dependent: :destroy
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'
  has_many :dm_messages, dependent: :destroy
  validates_uniqueness_of :sender_id, scope: :recipient_id
  scope :between, -> (sender_id,recipient_id) do
    where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND  conversations.recipient_id =?)", sender_id,recipient_id, recipient_id,sender_id)
  end
  def target_user(current_user)
    if sender_id == current_user.id
      User.find(recipient_id)
    elsif recipient_id == current_user.id
      User.find(sender_id)
    end
  end

  def save_notification_dm_message!(current_user, dm_message_id, visited_id)
    notification = current_user.active_notifications.new(
      conversation_id: id,
      dm_message_id: dm_message_id,
      visited_id: visited_id,
      action: 'dm'
    )
    notification.save if notification.valid?
  end
end
