class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  belongs_to :user
  has_many :replies, dependent: :destroy

  has_many :likes
  has_many :liked_tweets, through: :likes, source: :user

  def is_liked?(user)
    self.liked_tweets.include?(user)
  end
end
