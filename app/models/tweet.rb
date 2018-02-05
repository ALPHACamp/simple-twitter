class Tweet < ApplicationRecord
  validates_presence_of :description, on: :create, message: "can't be blank"
  validates_length_of :description, maximum: 140

end
