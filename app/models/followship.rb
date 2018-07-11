class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }
  validate :cannot_follow_itself

  belongs_to :user, counter_cache: :followings_count
  belongs_to :following, class_name: "User", counter_cache: :followers_count
  
  def cannot_follow_itself
    if user_id == following_id
      errors.add(:user_id, "cannot follow itself")
    end
  end
end
