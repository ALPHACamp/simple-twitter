class Tweet < ApplicationRecord
  has_many :replies, dependent: :destroy
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :users_liked, through: :likes, source: :user
end
