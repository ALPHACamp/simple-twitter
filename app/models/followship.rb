class Followship < ApplicationRecord
  
  belongs_to :following, class_name: "User",counter_cache: :followers_count
  belongs_to :user, counter_cache: :followings_count
  validates_uniqueness_of :following_id, scope: :user_id
end
