class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }
  default_scope { order(created_at: :desc) }

  # belongs_to :user, counter_cache: true
  belongs_to :user
  belongs_to :following, class_name: "User"

end
