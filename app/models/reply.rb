class Reply < ApplicationRecord
  validates_presence_of :comment

  belongs_to :tweet, counter_cache: true
  belongs_to :user
end
