class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  # 需要 app/views/devise 裡找到樣板，加上 name 屬性
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  validates_presence_of :name
  validates_uniqueness_of :name
  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)


  has_many :tweets, dependent: :destroy

  has_many :replies

  has_many :likes, dependent: :restrict_with_error
  has_many :like_tweets, through: :likes, source: :tweet

  # 使用者的followships資料
  has_many :followships, dependent: :destroy
  # 此使用者追蹤的人
  has_many :followings, through: :followships

  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user
  

  


  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end


end
