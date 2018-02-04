class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140

  belongs_to :user
  has_many :replies, dependent: :destroy 

  def count_replies
    self.replies_count = self.replies.size
    self.save
  end

end
