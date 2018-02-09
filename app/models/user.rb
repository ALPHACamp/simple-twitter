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
  validates :name, uniqueness: { message: "name has already, please change it" }
  
  #關聯
  has_many :tweets,dependent: :destroy 

  has_many :replies, dependent: :restrict_with_error
  has_many :tweet_replies, through: :replies

  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet

  def admin?
    self.role == "admin"
  end  

  def profile?(user)
    self.name.include?(user.name)    
  end

  def count_likes
    self.likes_count = self.likes.size
    self.save
  end
  
end
