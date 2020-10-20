class GroupMessage < ApplicationRecord
  mount_uploader :group_music, AudioUploader
  belongs_to :group
  belongs_to :user

  validates :body, presence: true
end
