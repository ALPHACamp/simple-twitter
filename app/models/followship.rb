class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }
  
  belongs_to :user
  belongs_to :following, class_name: "User" 
  #followship裡面有個following id，但沒有following這個model，所以要用class_name把這個id指向USER model

  after_destroy :update_to_user
  after_save :update_to_user
 
  def update_to_user
    self.following.followers_count!
  end


end
