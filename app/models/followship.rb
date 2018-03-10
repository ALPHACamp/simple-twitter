class Followship < ApplicationRecord
  # 使用者不能重複追蹤同樣的人
  validates :following_id, uniqueness: { scope: :user_id }

  # 追蹤記錄屬於使用者
  belongs_to :user, counter_cache: true
  # 追蹤記錄屬於被追蹤的人
  belongs_to :following, class_name: "User"

  # 追蹤記錄也屬於追蹤 current_user 的人，以爲這樣能讓 followers_count 能用
  # belongs_to :follower, class_name: "User", foreign_key: "user_id"

end
