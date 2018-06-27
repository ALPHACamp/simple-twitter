class Reply < ApplicationRecord
  validates :comment, presence: true
  belongs_to :user
  belongs_to :tweet, counter_cache: true
end
