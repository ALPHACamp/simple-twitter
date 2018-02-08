class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }

  # 一個followship屬於一個user
  belongs_to :user
  # 一個followsip屬於另一個following user
  belongs_to :following, class_name: "User"
  

end
