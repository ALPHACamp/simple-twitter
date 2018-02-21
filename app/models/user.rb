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


  # 建立管理者認證
  def admin?
  	self.role == "admin"
  end	

end
