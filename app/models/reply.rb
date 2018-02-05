class Reply < ApplicationRecord
  validates_length_of :comment, maximum: 100

  belongs_to :user
  belongs_to :tweet
end
