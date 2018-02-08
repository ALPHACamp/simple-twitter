class Reply < ApplicationRecord
  validates_presence_of :comment
  belongs_to :user, optional: true
  belongs_to :tweet, optional: true
end
