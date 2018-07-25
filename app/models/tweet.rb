class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
# 建立user跟tweet的關聯，一個tweet只會有一個user
  belongs_to :user
# tweet限制字數及空白
  validates :user_id, presence: true
  validates :description, presence: true, length: {maximum: 140}

end
