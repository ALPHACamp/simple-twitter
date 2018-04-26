class Reply < ApplicationRecord
  validates_presence_of :comment, on: :create, message: "Can't be blank"
  belongs_to :user
  belongs_to :tweet, counter_cache: true
end
