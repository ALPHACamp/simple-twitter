class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }

  belongs_to :user
  # 每當following增加，followers_count就會做累加
  belongs_to :following, class_name: "User", counter_cache: :followers_count
end
