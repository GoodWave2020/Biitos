class Post < ApplicationRecord
  mount_uploader :picture, ImageUploader
  mount_uploader :music, AudioUploader
  with_options presence: true do
    validates :title
    validates :music
    validates :picture
    validates :type
  end
end
