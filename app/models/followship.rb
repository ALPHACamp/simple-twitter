class Followship < ApplicationRecord
  # 限制使用者只能追蹤另一個使用者一次
  validates :following_id, uniqueness: { scope: :user_id }
  # 限制是否追蹤自己
  validate :check_self_following
  belongs_to :user
  belongs_to :following, class_name:"User" ,counter_cache: :followers_count

  def check_self_following
    if user_id == following_id
      errors[:following_id] <<  "Can's follow yourself"
    end
  end
end
