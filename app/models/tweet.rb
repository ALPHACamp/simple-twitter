class Tweet < ApplicationRecord
  validates_presence_of :description
  validates_length_of :description, maximum: 140

  belongs_to :user
  has_many :replies, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def is_liked?(user)
    self.liked_users.include?(user)
  end

  def update_count
    self.update(replies_count: self.replies.count)
    self.update(likes_count: self.likes.count)
  end

end
