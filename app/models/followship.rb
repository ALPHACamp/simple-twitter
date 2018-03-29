class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }
  validate :check_self_following
  #檢查是否追蹤自己
  belongs_to :user
  belongs_to :following, class_name: "User",counter_cache: :followers_count
  

  def check_self_following
    if user_id == following_id
      errors[:following_id]<<"can't follow yourself!"
    end
  end
end
