class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :icon, ImageUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options presence: true do
    validates :name
    validates :artist_type
  end
  enum artist_type: {
    Voicer: 0,
    Tuner: 1,
  }
  has_many :posts
end
