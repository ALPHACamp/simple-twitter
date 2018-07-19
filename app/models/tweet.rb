class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  validates_presence_of :description

  belongs_to :user,counter_cache: true

  #like
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  #reply
  has_many :replies, dependent: :destroy

  def like?(user)
    self.liked_users.include?(user)
  end

end
