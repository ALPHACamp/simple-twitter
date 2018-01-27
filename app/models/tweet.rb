class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140

end
