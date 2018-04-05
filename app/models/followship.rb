class Followship < ApplicationRecord
  belongs_to :user
  belongs_to :following, class_name: "User"
  validates :following_id, uniqueness: { scope: :user_id }

end
