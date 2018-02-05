class Tweet < ApplicationRecord
  has_many :replies
  belongs_to :user
  validates_length_of :description, maximum: 140

end
