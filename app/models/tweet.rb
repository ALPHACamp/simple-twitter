class Tweet < ApplicationRecord
  validates_length_of :description, minimum: 1, maximum: 140

  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user

  def is_liked?(user)
    self.like_users.include?(user)
  end
end
