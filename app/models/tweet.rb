class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  validates_presence_of :description #description必填

  belongs_to :user
  has_many :replies
end
