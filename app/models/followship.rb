class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }
  validates :following_id, presence: true, unless: :user_is_follower?

  belongs_to :user
  belongs_to :following, class_name: "User"

  def user_is_follower?
    self.user_id == following_id
  end

end
