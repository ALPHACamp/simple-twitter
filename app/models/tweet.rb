class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140

  has_many :replies

  belongs_to :user, optional: :ture

  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  def is_liked?(user)
    self.liked_users.include?(user)
  end

end
