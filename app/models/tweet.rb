class Tweet < ApplicationRecord
  belongs_to :user, dependent: :destroy

  validates_length_of :description, maximum: 140

end
