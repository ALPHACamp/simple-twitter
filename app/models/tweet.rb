class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  belongs_to :user
  has_many :replies, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  def is_liked?(user)
    self.liking_users.include?(user)
  end

end
