class Tweet < ApplicationRecord
  validates :description, presence: true, length: { maximum: 140 }
  belongs_to :user
  has_many :likes, dependent: :destroy

end
