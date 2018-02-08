class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  belongs_to :tweet, counter_cache: true
end
