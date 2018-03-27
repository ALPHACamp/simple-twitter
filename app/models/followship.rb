class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }
  validate :following_self
  # 自訂無法追蹤自己方法

  belongs_to :user
  belongs_to :following, class_name: "User"


  def following_self
    if user_id == following_id
      errors[:following_id]<<"can't follow yourself!"
    end
  end

end
