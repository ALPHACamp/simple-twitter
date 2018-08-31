class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  belongs_to :user
  has_many :replies, dependent: :destroy
  has_many :replied_users, through: :replies, source: :user
end
