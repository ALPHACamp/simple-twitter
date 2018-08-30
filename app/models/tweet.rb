class Tweet < ApplicationRecord
  validates_presence_of :description
  validates_length_of :description, maximum: 140
  belongs_to :user, counter_cache: :tweets_count
  has_many :replies, dependent: :destroy
  has_many :likes, dependent: :destroy
end
