class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tweet, counter_cache: true
end
