class Tweet < ApplicationRecord
  belongs_to :user
  validates_length_of :description, maximum: 140
  has_many :replies, dependent: :destroy 


  def count_replies
    self.replies_count = self.replies.size
    self.save
  end
end
