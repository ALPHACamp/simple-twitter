class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  # 需要 app/views/devise 裡找到樣板，加上 name 屬性
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  validates_presence_of :name
  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)

  # User 若有推播，就不允許刪除帳號（刪除時拋出 Error）
  has_many :tweets, dependent: :restrict_with_error
  # 回覆推播
  has_many :replies, dependent: :destroy

  has_many :followships
  #user/followship已建立關係, 所以無需增加 source: :user
  has_many :followings, through: :followships
  #透過Followship的foreign_key取得追隨者的資料
  has_many :self_follower, class_name: "Followship", foreign_key: "following_id", dependent: :destroy
  has_many :followers, through: :self_follower, source: :user

  
  has_many :likes

  def admin?
    self.role == "admin"
  end

  # 是否已追蹤 
  def following?(user)
    self.followings.include?(user)
  end
  
end
