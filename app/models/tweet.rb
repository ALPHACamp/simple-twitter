class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140

  belongs_to :user,  optional: true

  has_many :replies, dependent: :destroy
  has_many :replied_users, through: :replies

  has_many :replies, dependent: :destroy
  has_many :replied_users, through: :replies, source: :user

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user  

end
