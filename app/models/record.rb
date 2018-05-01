class Record < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence: true
  validates :weight, presence: true
  validates :fatPer, presence: true
end
