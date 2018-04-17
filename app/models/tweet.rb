class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :likes_users, through: :likes, source: :user
  has_many :replies,dependent: :destroy
  has_many :users , through: :replies
  def is_likes?(user)
      self.likes_users.include?(user)
    end
end
