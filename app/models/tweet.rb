class Tweet < ApplicationRecord
  # 每一則推播限制 140 個字
  validates_length_of :description, maximum: 140

  # 每一個推播都屬於特定的使用者
  belongs_to :user

  # 一個推播底下會有很多的回覆
  has_many :replies, dependent: :destroy

  # 在 Model 加入驗證程序
  validates_presence_of :description

  # 「使用者喜歡很多推播」的多對多關聯
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  # 檢查喜歡紀錄是否存在
  def is_liked?(user)
    self.liked_users.include?(user)
  end  

end
