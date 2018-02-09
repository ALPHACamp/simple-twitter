class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  belongs_to :user
  has_many :replies

  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet
end
