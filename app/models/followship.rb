class Followship < ApplicationRecord
  validates :following_id, uniqueness: {scope: :user_id }
  after_save :update_to_user

  belongs_to :user
  belongs_to :following, class_name: "User"

  def update_to_user
    self.following.followers_count!
  end
  
end
