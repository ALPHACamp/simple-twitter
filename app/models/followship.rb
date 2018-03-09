class Followship < ApplicationRecord
  # 使用者不能重複追蹤同樣的人
  validates :following_id, uniqueness: { scope: :user_id }

  # 追蹤記錄屬於使用者
  belongs_to :user, counter_cache: true
  # 追蹤記錄屬於被追蹤的人
  belongs_to :following, class_name: "User"

  # 對於同一個 user 建立的 followship，不能有重複的關係
  validates :following_id, uniqueness: { scope: :user_id }
end
