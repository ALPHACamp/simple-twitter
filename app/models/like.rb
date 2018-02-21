class Like < ApplicationRecord

# 使用者有很多喜歡的推播
belongs_to :user

# 推播被很多使用者有很多喜歡
belongs_to :tweet

end
