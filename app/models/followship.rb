class Followship < ApplicationRecord
  # 加入 Model 驗證，每個 User 只能追蹤另一個 User 一次
  validates :following_id, uniqueness: { scope: :user_id }

  belongs_to :user # 每一筆追蹤紀錄，屬於發出追蹤的使用者 (User)
  belongs_to :following, class_name: "User", counter_cache: :followers_count # 每一筆追蹤紀錄，屬於被追蹤的使用者 (following)
end
