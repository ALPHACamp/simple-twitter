class Tweet < ApplicationRecord
  belongs_to :user
  has_many :replies
  validates_length_of :description, maximum: 140
  validates_presence_of :description

end
