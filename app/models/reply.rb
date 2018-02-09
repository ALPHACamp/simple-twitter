class Reply < ApplicationRecord

  # 設定關聯
  belongs_to :tweet, :counter_cache => true
  belongs_to :user
end
