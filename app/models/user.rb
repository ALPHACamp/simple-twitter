class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # 照片上傳功能
  mount_uploader :avatar, AvatarUploader

  # 需要 app/views/devise 裡找到樣板，加上 name 屬性
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  validates_presence_of :name
  
  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)
  validates_uniqueness_of :name

  # 一個使用者可以發表很多的推播
  has_many :tweets

  # 一個使用者可以有很多的回覆
  has_many :replies

  # 「使用者喜歡很多推播」的多對多關聯
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet

  has_many :followships, dependent: :destroy # 一個 User 擁有很多追蹤紀錄
  has_many :followings, through: :followships # 透過追蹤紀錄，一個 User 追蹤很多其他 User (followings)

  # 使用者的追蹤者設定
  # 透過 class_name, foreign_key 的自訂，指向 Followship 表上的另一側
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id" 
  has_many :followers, through: :inverse_followships, source: :user

  # 建立管理者認證
  def admin?
  	self.role == "admin"
  end

  # 檢查是否追蹤紀錄已經存在 : following?
  def following?(user)
    self.followings.include?(user)
  end

end
