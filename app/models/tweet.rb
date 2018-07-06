class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  validates_presence_of :description
  belongs_to :user
end
