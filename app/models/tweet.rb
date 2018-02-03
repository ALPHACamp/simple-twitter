class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140

  has_many :replies

  belongs_to :user, optional: :ture

end
