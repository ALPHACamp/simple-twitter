class Reply < ApplicationRecord
  validates_length_of :comment, maximum: 140
  validates_presence_of :comment
  default_scope { order(created_at: :asc) }

  belongs_to :tweet, counter_cache: true
  belongs_to :user
end
