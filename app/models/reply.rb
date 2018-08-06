class Reply < ApplicationRecord
  validates_presence_of :comment

  belongs_to :user
  belongs_to :tweet
end