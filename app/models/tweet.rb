class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  validates_presence_of :description

  belongs_to :user, optional: true
  has_many :replies, dependent: :delete_all

  has_many :likes, dependent: :delete_all
  has_many :liked_users, through: :likes, source: :user

  def is_liked?(user)
    self.liked_users.include?(user)
  end

end
