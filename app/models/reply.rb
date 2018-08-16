class Reply < ApplicationRecord
  # counter_cache 可以自動回傳 size 方法結果，計算關聯物件數量
  belongs_to :user, counter_cache: true
  belongs_to :tweet, counter_cache: true
end
