class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # mount_uploader :avatar, AvatarUploader

  # 需要 app/views/devise 裡找到樣板，加上 name 屬性
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  validates_presence_of :name
  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)
  validates_uniqueness_of :email, :name

  # 設置user 與 tweet的一對多關係
  has_many :tweets, dependent: :destroy
  # 使用者能對別人的推播按 Like/Unlike的多對多關係
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet

  # 使用者追蹤很多使用者的多對多關聯
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships
  # 使用者被很多使用者追蹤的多對多關聯
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id", dependent: :destroy
  has_many :followers, through: :inverse_followships, source: :user

  # 使用者能回覆別人的推播的多對多關係
  has_many :replies, dependent: :destroy
  has_many :replied_tweets, through: :replies, source: :tweet

  def admin?
    self.role == 'admin'
  end

  def following?(user)
    self.followings.include?(user)
  end

  # def count_followers
  #   self.followers_count = self.followers.count
  #   self.save
  # end
end
