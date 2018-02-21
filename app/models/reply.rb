class Reply < ApplicationRecord

# 回覆是屬於特定使用者
# 回覆是屬於特定推播
belongs_to :user
belongs_to :tweet

# 在 Model 加入驗證程序
validates_presence_of :comment

end
