class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140

  belongs_to :user
  has_many :replies, dependent: :destroy

  has_many :likes, dependent: :destroy

  def is_liked?(user)
    self.likes.include?(user)
  end
end

