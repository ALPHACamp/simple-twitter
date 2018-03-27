class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  belongs_to :user, counter_cache: true
  has_many :likes, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
end
