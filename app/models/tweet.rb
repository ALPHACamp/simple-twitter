class Tweet < ApplicationRecord
  # 每一則推播限制 140 個字
  validates_length_of :description, maximum: 140

  # 每一個推播都屬於特定的使用者
  belongs_to :user

  # 一個推播底下會有很多的回覆
  has_many :replies

  # 在 Model 加入驗證程序
  validates_presence_of :description

end
