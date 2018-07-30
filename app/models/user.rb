class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader
  has_many :tweets

  # 需要 app/views/devise 裡找到樣板，加上 name 屬性
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  validates_presence_of :name
  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)
  validates_uniqueness_of :name
  #建立追蹤關係
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships
  #被誰追蹤
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id" #主鍵指向following_id
  has_many :followers, through: :inverse_followships, source: :user
  # 建立多對多的關係，回應
  has_many :replies, dependent: :restrict_with_error
  # has_many :restaurants, through: :comments =>>已經擁有tweets
  # 建立喜歡
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes , source: :likes
  
  def admin?
    self.role == "admin"
  end
  def following?(user)
    self.followings.include?(user)
  end
end
