class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }
  validate :disallow_self_follow

  belongs_to :user
  belongs_to :following, class_name: "User"

  private

  # 自訂驗證：避免follow到自己
  def disallow_self_follow
    if user_id == following_id
      errors[:following_id] << 'cannot follow self'
    end
  end

end
