class Tweet < ApplicationRecord
  belongs_to :user, dependent: :destroy
  # likes
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  # relplies
  has_many :replies, dependent: :destroy
  has_many :replied_users, through: :replies, source: :user

  validates_length_of :description, maximum: 140

  def is_liked?(user)
    self.liked_users.include?(user)
  end

  def count_likes
    self.likes_count = self.likes.size
    self.save
  end

end
