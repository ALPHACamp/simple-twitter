class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140

  belongs_to :user, counter_cache: true

  validates_presence_of :description

  has_many :replies, dependent: :destroy

  has_many :likes,dependent: :destroy 
  has_many :like_users, through: :likes, source: :user

  def is_liked?(user)
    self.like_users.include?(user)
  end

end
