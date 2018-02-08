class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140

  belongs_to :user

  has_many :replies, dependent: :destroy
  has_many :replying_users, through: :replies, source: :user

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def liked_by_user?(user)
  	self.liked_users.include?(user)
  end

end
