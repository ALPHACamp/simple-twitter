class Tweet < ApplicationRecord
  # 每一則推播限制 140 個字
  validates_length_of :description, maximum: 140

  # 每一個推播都屬於特定的使用者
  belongs_to :user

end
