class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
# 建立user跟tweet的關聯，一個tweet只會有一個user
  belongs_to :user, counter_cache: true
# tweet限制字數及空白
  validates :user_id, presence: true
  validates :description, presence: true, length: {maximum: 140}
# tweet有很多回覆，當tweet被刪除時，順便刪除回覆
  has_many :replies, dependent: :destroy

# 使用者可以喜歡很多評論
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def is_liked?(user)
    self.liked_users.include?(user)
  end
end
