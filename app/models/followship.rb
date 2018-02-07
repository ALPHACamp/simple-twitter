class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }
  default_scope { order(created_at: :desc) }

end
