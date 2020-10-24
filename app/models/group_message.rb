class GroupMessage < ApplicationRecord
  mount_uploader :group_music, AudioUploader
  belongs_to :group
  belongs_to :user

  validates :body, presence: true

  def group_message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end

  def file_url
    if Rails.env.production?
      "https://s3-ap-northeast-1.amazonaws.com/biitos-rails/uploads/group_message/group_music/#{self.id}/#{self.file_name}"
    else
      "public/uploads/group_message/group_music/#{self.id}/#{self.file_name}"
    end
  end

  def file_name
    self.group_music.file.filename
  end

  def content_type
    self.group_music.content_type
  end
end
