class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }
  belongs_to :user
	belongs_to :following,counter_cache: :followers_count, class_name:"User"
end
