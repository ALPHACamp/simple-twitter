class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  belongs_to :user
  has_many :replies

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user


  def is_liked?(user)
    self.liked_users.include?(user)
  end
  
end
