class Tweet < ApplicationRecord
  belongs_to :user
  
  has_many :replies, dependent: :destroy
  
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

end
