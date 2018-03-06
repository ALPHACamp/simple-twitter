class Tweet < ApplicationRecord
  # 限制推文長度
  validates_length_of :description, maximum: 140

  # 有個外鍵是 user_id
  belongs_to :user
end
