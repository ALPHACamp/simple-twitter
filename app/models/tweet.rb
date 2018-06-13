class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  validates_presence_of :description  #內容不得空白

  belongs_to :user
  has_many :replies
end
