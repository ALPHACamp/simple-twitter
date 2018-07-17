class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140

  belongs_to :user

  validates_presence_of :description

end
