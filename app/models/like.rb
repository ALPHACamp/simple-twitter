class Like < ApplicationRecord

# 使用者有很多喜歡的推播
belongs_to :user

# 推播被很多使用者有很多喜歡 / 改成使用內建的 counter_cache 功能來計算喜歡數
belongs_to :tweet, counter_cache: true

end
