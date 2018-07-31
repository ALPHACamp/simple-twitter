class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140

  belongs_to :user, counter_cache: true
  
  has_many :replies, dependent: :destroy
  has_many :replied_users, through: :replies, source: :user

  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :user

  def count_likes
    self.likes_count = self.like.size
    self.save
  end

  def is_liked?(tweet)
    self.liked_tweets.include?(tweet)
  end


end
