class Like < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :tweet
end
