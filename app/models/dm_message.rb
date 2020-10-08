class DmMessage < ApplicationRecord
  mount_uploader :collab_music, AudioUploader
  belongs_to :conversation
  belongs_to :user
  validates_presence_of :body, :conversation_id, :user_id
  def dm_message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
  def file_url
    if Rails.env.production?
      "https://s3-ap-northeast-1.amazonaws.com/biitos-rails/uploads/dm_message/collab_music/#{self.id}/#{self.file_name}"
    else
      "public/uploads/dm_message/collab_music/#{self.id}/#{self.file_name}"
    end
  end

  def file_name
    self.collab_music.file.filename
  end

  def content_type
    self.collab_music.content_type
  end
end
