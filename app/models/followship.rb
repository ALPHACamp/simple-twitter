class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }

  belongs_to :user # 每一筆追蹤紀錄，屬於發出追蹤的使用者 (User)
  belongs_to :following, class_name: "User" # 每一筆追蹤紀錄，屬於被追蹤的使用者 (following)

end
