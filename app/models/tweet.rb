class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  # 設置tweet 與 user的多對一關係
  belongs_to :user
  # 使用者能對別人的推播按 Like/Unlike的多對多關係
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  # 使用者能回覆別人的推播的多對多關係
  has_many :replies, dependent: :destroy
  has_many :replied_users, through: :replies, source: :user

  def is_liked?(user)
    self.liked_users.include?(user)
  end

end
