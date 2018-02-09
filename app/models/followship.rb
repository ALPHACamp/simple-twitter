class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }
  
  #belongs_to :user, class_name: "User", foreign_key: "user_id", primary_key: "id"
  belongs_to :user
  #belongs_to :following, class_name: "User", foreign_key: "following_id", primary_key: "id"
  belongs_to :following, class_name: "User"
end
