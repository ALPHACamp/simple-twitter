class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }

  belongs_to :user
  belongs_to :following, class_name: "User", counter_cache: :followers_count
  validates :user, presence: true
  validates :following, presence: true
  validate :not_following_himself

  def not_following_himself
    if following_id == user_id 
      errors.add :user_id
    end
  end
end
