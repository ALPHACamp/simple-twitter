class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  default_scope { order(created_at: :desc) }
  belongs_to :user, counter_cache: true
  has_many :replies, dependent: :destroy


  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
end
