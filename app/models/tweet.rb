class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140

  belongs_to :user, :counter_cache => true
  has_many :replies
  has_many :likes
end
