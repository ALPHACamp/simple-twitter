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
  
  # 使用者有很多追蹝記錄，也有很多他自己正在追蹤的人
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  has_many :tweets
  
  has_many :replies
  
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet
  
  def count_followers
    self.followers_count = self.followers.size
    self.save
  end
  
  def count_likes
    self.likes_count = self.likes.size
    self.save
  end
  
  def admin?
    self.role == "admin"
  end
  
  def following?(user)
    self.followings.include?(user)
  end
  
end
