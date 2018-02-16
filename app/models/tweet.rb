class Tweet < ApplicationRecord
  #主體，推特
  
  #推文不得空白
  validates_presence_of :description, on: :create, message: "can't be blank"
  #限制發文數量
  validates_length_of :description, maximum: 140
  
  #處理user的關聯
  belongs_to :user, optional: true

  #處理reply的關聯
  has_many :replies, class_name: "Reply", dependent: :destroy

  #處理like的關聯
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def is_liked?(user)
    self.liked_users.include?(user)
  end

  def count_likes
    self.likes_count = self.likes.size
    self.save
  end

  def count_replies
    self.replies_count = self.replies.size
    self.save
  end

end