class Post < ApplicationRecord
  mount_uploader :picture, ImageUploader
  mount_uploader :music, AudioUploader
  with_options presence: true do
    validates :title
    validates :music
    validates :music_type
  end
  enum music_type: {
    Voice: 0,
    Tune: 1,
    Collabolated: 2
  }
  enum genre: [
    :Jazz,
    :Hiphop,
    :RnB,
    :Electro,
    :Folk,
    :Funk,
    :House,
    :Blues,
    :Rock,
    :Soul,
    :Techno,
    :Pop,
    :Country,
    :Gospel
  ]
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
  has_many :notifications, dependent: :destroy
  def save_labels(labels)
    current_labels = self.labels.pluck(:name) unless self.labels.nil?
    old_labels = current_labels - labels
    new_labels = labels - current_labels
    # Destroy old taggings:
    old_labels.each do |old_name|
      self.labels.delete Label.find_by(name:old_name)
    end

    # Create new taggings:
    new_labels.each do |new_name|
      labelling = Label.find_or_create_by(name:new_name)
      self.labels << labelling
    end
  end

  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
        save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
