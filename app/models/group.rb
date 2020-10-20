class Group < ApplicationRecord
  has_many :owner, class_name: "User"
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
end
