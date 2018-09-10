class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  # 需要 app/views/devise 裡找到樣板，加上 name 屬性
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  validates_presence_of :name, :email, :password
  validates :name, uniqueness: {case_sensitive: true}
  

  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)

  has_many :tweets
  has_many :replies
  has_many :likes
  has_many :liked_tweets, through: :likes, source: :tweet
  has_many :followships 
  has_many :followings, through: :followships 
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user
  scope :recent, -> {order("created_at DESC")}
  
  def admin?
    if self.role == "admin"
    	true
    else
    	false
    end
  end

  def is_following?(user)
    self.followings.include?(user)
  end

  def already_liked?(tweet)
    self.liked_tweets.include?(tweet)
  end


end
