class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :tweet, :counter_cathe => true
end
