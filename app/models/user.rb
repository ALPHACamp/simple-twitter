class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader
  validates_presence_of :name
  # 需要 app/views/devise 裡找到樣板，加上 name 屬性
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  validates :name, uniqueness: true
  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)

  has_many :tweets, dependent: :destroy
  #使用者有很多追蹤的人
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  #使用者的追蹤者
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

  #「使用者喜歡很多推文」的多對多關係
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet

  # 使用者有很多回覆
  has_many :replies

  def admin?
    self.role == "admin"
  end

  def following?(user)
      self.followings.include?(user)
  end
end
