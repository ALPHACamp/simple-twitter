class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140

  # 一則 tweet 只屬於一個 user
  belongs_to :user

  # 一則 tweet 會有多個 reply
  has_many :replies, dependent: :destroy

end
