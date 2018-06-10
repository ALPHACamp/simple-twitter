class Tweet < ApplicationRecord
  validates_presence_of :description
  validates_length_of :description, maximum: 140

end
