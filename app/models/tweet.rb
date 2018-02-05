class Tweet < ApplicationRecord
  has_many :replies
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  belongs_to :user
  validates_length_of :description, maximum: 140

  def is_liked?(user)
    self.liked_users.include?(user)
  end
end
