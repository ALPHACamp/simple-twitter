class Like < ApplicationRecord
  belongs_to :user, counter_cache: :likes_count #user喜歡幾筆tweet
  belongs_to :tweet, counter_cache: :likes_count #tweet被喜歡的user人數
end
