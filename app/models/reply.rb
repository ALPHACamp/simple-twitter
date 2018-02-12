class Reply < ApplicationRecord
  validates_length_of :comment, maximum: 140
  belongs_to :user
  belongs_to :tweet, counter_cache: true

end
