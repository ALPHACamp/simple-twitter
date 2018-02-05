class Tweet < ApplicationRecord
  belongs_to :user
  validates_length_of :description, maximum: 140

end
