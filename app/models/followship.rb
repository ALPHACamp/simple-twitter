class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }

  belongs_to :user 
  belongs_to :following, class_name: "User"

  def count_followers
    current_user.followers_count = current_user.followers.size
    current_user.save
  end

end
