class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  # 需要 app/views/devise 裡找到樣板，加上 name 屬性
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法

  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)
  validates_uniqueness_of :name, :case_sensitive => false

  has_many :tweets, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :like_tweets, through: :likes, source: :tweet, dependent: :destroy


  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships


  # admin? 判斷單個user是否有 admin 角色，列如：current_user.admin?
  def admin?
    self.role == "admin"
  end


  def following?(user)
    self.followings.include?(user)
  end

  def like?(tweet)
    self.like_tweets.include?(tweet)
  end
end
