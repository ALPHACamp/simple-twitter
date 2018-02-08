class Followship < ApplicationRecord

  # 確保特定 user_id 下，只能有一個 friend_id
  validates :following_id, uniqueness: { scope: :user_id }

  # 屬於發出追蹤的人
  belongs_to :user
  # 屬於被追蹤的人
  belongs_to :following, class_name: "User" 

end
