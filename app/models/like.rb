class Like < ApplicationRecord
  validates :tweet_id, uniqueness: { scope: :user_id }
  belongs_to :user, counter_cache: true
  belongs_to :tweet, counter_cache: true
end
