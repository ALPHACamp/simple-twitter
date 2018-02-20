class Reply < ApplicationRecord

# 回覆是屬於特定使用者
# 回覆是屬於特定推播
belongs_to :user
belongs_to :tweet

end
