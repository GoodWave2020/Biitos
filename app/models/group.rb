class Group < ApplicationRecord
  has_many :owner, class_name: "User"
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :group_messages

  def show_last_message
    if (last_message = group_messages.last).present?
      last_message.body? ? last_message.body : '音楽が投稿されています。'
    else
      'まだメッセージはありません。'
    end
  end
end
