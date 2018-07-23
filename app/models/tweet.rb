class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140 #一個推播最多140個字

  # 一個推播屬於一個使用者
  belongs_to :user 

  # 推播可被多個使用者like
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  # 推播可以有多個回覆
  has_many :replies, dependent: :destroy

  # 判斷是否已收藏
  def is_liked?(user)
    self.liked_users.include?(user)
  end

  # 計算like數量
  def count_likes
    self.likes_count = self.likes.size
    self.save
  end
end
