class Group < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :group_messages, dependent: :destroy

  def show_last_message
    if (last_message = group_messages.last).present?
      last_message.body? ? last_message.body : '音楽が投稿されています。'
    else
      'まだメッセージはありません。'
    end
  end
end
