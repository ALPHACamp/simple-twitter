class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }

  belongs_to :user, foreign_key: "following_id", counter_cache: :followers_count
  belongs_to :following, class_name: "User"
end
