class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }
end
