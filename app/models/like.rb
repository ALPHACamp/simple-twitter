class Like < ApplicationRecord
  # 喜好記錄屬於使用者
  belongs_to :user, counter_cache: true

  # 喜好記錄屬於推文
  belongs_to :tweet, counter_cache: true

  # 使用者不能喜歡同樣的推文
  validates :tweet_id, uniqueness: { scope: :user_id }
end
