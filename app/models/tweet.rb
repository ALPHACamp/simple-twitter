class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  belongs_to :user
  has_many :replies
end
