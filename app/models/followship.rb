class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }
  belongs_to :following, class_name: "User",counter_cache: :followers_count
  belongs_to :user 
end
