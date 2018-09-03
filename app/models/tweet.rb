class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140

  # 一則 tweet 只屬於一個 user
  # 計算推播數
  belongs_to :user, counter_cache: true

  # 一則 tweet 會有多個 reply
  has_many :replies, dependent: :destroy

  # 一則 tweet 會有很多 user 按 like
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  # 檢查 like 紀錄是否存在
  def is_liked?(user)
    self.liked_users.include?(user)
  end

end
