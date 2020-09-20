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
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings

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
end
