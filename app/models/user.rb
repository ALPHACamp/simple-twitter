class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # user大頭照照片上傳器
  mount_uploader :avatar, AvatarUploader

  # 設定user跟tweet關聯，一個user可以有很多tweets
  has_many :tweets, dependent: :destroy
  # 設定追蹤關聯紀錄
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  # 設定追蹤者關聯
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

  # 設定使用者喜歡很多評論多對多關聯
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet

  # 需要 app/views/devise 裡找到樣板，加上 name 屬性
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)
  validates_presence_of :name, :uniqueness => {:case_sensitive => false}

def admin?
  self.role == "admin"
end

def following?(user)
  self.followings.include?(user)
end
def followers_count
  self.followers_count = self.followers.count
  self.save
end
def tweets_count
  self.tweets_count = self.tweets.count
  self.save
end

end
