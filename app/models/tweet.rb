class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  
  belongs_to :user, counter_cache: :tweets_count
  has_many :replies, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  
  # 驗證使用者是否已點選過喜愛按鈕
  def is_liked?(user)
    self.liked_users.include?(user)
  end
end
