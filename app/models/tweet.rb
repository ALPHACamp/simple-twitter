class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140

  belongs_to :user

  # tweets的replies
  has_many :replies, dependent: :destroy
  has_many :reply_users, through: :replies, source: :user
end
