class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140

  belongs_to :user

  validates_presence_of :description

  has_many :replies, dependent: :destroy

  has_many :likes,dependent: :destroy 
  has_many :liked_users, through: :likes, source: :user

end
