class Reply < ApplicationRecord
  validates_presence_of :comment
  
  belongs_to :tweet
  belongs_to :user
end
