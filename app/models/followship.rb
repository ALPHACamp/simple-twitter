class Followship < ApplicationRecord
  # 使用者不能重複追蹤同樣的人
  validates :following_id, uniqueness: { scope: :user_id }

  # 追蹤記錄屬於使用者
  belongs_to :user
  # 追蹤記錄屬於被追蹤的人
  belongs_to :following, class_name: "User"
end
