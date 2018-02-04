class Followship < ApplicationRecord
  # 每個 User 只能追蹤另一個 User 一次
  validates :following_id, uniqueness: { scope: :user_id }

  belongs_to :user
  belongs_to :following, class_name: "User"
end
