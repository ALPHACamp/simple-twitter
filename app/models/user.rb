class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  # 需要 app/views/devise 裡找到樣板，加上 name 屬性      V
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法   V
  validates_uniqueness_of :name
  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)   V


  

  has_many :replies
  has_many :tweets, through: :replies

  has_many :likes
  has_many :liked_tweets, through: :likes, source: :tweet


end
