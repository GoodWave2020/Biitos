class DmMessage < ApplicationRecord
  mount_uploader :collab_music, AudioUploader
  belongs_to :conversation
  belongs_to :user
  validates_presence_of :body, :conversation_id, :user_id
  def dm_message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
  def file_url
    "public/uploads/dm_message/collab_music/#{self.id}/#{self.file_name}"
  end

  def file_name
    self.collab_music.file.filename
  end

  def content_type
    self.collab_music.content_type
  end
end
