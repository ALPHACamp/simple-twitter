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
  validates_uniqueness_of :name

#user可以發很多篇Tweets
  has_many :tweets

#user可以發很多篇Replies
  has_many :replies, dependent: :destroy
  has_many :replied_tweet, through: :replies, source: :tweets


# User可以喜歡很多文，如果User刪掉的話 喜歡的關係也要被刪掉
  has_many :likes, dependent: :destroy
  has_many :liked_tweet, through: :likes, source: :tweets

# User可以跟隨很多人，如果User刪掉的話 follow關係也要被刪掉 也可以被很多人跟隨
  has_many :followships, dependent: :destroy
  has_many :following, through: :followships


end
