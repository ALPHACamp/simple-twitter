class Reply < ApplicationRecord
  validates_presence_of :comment
  default_scope { order(created_at: :desc) }

  belongs_to :user
  belongs_to :tweet
end
