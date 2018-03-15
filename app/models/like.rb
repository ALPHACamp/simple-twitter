class Like < ApplicationRecord
  belongs_to :user
  #如何知道被喜歡

  #counter_cache 計算關聯物件的數量
  belongs_to :tweet, counter_cache: true
end
