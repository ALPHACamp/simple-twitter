class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }
  validate :can_not_follow_self

  belongs_to :user
  belongs_to :following, class_name: "User", counter_cache: :followers_count

  def can_not_follow_self
    if following_id == user_id
      errors.add(:following_id, "Can't follow self")
    end
  end
end