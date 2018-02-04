class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  validates_numericality_of :replies_count, greater_than_or_equal_to: 0

  belongs_to :user, optional: true
  has_many :replies, dependent: :destroy

end
