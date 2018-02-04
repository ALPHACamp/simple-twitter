class Tweet < ApplicationRecord
  validates_length_of :description, minimum: 1, maximum: 140

  belongs_to :user
end
