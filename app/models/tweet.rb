class Tweet < ApplicationRecord
  #主體，推特
  
  #推文不得空白
  validates_presence_of :description, on: :create, message: "can't be blank"
  #限制發文數量
  validates_length_of :description, maximum: 140
  
  #處理user的關聯
  belongs_to :user, class_name: "User", foreign_key: "user_id"

  #處理reply的關聯
  has_many :replies, class_name: "Reply", foreign_key: "reference_id", dependent: :destroy

  #處理like的關聯
  has_many :likes, class_name: "Like", foreign_key: "reference_id", dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def is_liked?(user)
    self.liked_users.include?(user)
  end

  #統計like的數量
  def count_likes
    self.likes_count = self.likes.size
    self.save
  end

  #統計reply的數量
  def count_replies
    self.replies_count = self.likes.size
    self.save
  end
end
