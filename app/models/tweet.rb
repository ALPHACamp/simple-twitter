class Tweet < ApplicationRecord
  belongs_to :user
  has_many :replies, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  validates_length_of :description, maximum: 140
  validates_presence_of :description

end
