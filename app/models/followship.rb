class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }
  
  belongs_to :user, optional: true
  belongs_to :following, class_name: "User"

end
