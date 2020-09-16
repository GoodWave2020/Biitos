class Post < ApplicationRecord
  mount_uploader :picture, ImageUploader
  with_options presence: true do
    validates :title
    validates :music
    validates :picture
    validates :type
  end
end
