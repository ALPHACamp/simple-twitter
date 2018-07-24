class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  validates_presence_of :name

  belongs_to :user, optional: true
  has_many :replies, dependent: :destroy

end
