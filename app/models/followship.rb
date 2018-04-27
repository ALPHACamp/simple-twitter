class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }

  belongs_to :user #追蹤記錄，屬於發出追蹤的使用者(user) 
  belongs_to :following, class_name: 'User' #, foreign_key: "following_id", primary_key: "id"
  #追蹤記錄，屬於被追蹤的使用者(following) 

end
