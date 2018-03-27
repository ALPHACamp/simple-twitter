class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :tweet, counter_cache: true
  validates_presence_of :comment
end
