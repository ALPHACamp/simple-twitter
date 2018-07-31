class Like < ApplicationRecord
  belongs_to :user, counter_cache: true
  bleongs_to :tweet, conuter_cache: true
end
