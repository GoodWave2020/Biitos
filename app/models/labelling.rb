class Labelling < ApplicationRecord
  belongs_to :post
  belongs_to :label
  validates :post_id,presence:true
  validates :label_id,presence:true
end
