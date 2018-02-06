class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  # 需要 app/views/devise 裡找到樣板，加上 name 屬性
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  validates_presence_of :name, uniqueness: true
  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)

  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet
  has_many :replies, dependent: :destroy

  # 「使用者可以追蹤很多其他使用者」的自關聯
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  # 自關聯的逆向方法:@user可以逆向追蹤follower(設定@user為following的users)
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user, counter_cache: true

# admin? 判斷單個user是否有 admin 角色，列如：current_user.admin?
  def admin?
    self.role == "admin" 
  end

  #判斷該user是否有追蹤指定之(user)
  def following?(user)
    self.followings.include?(user)      
  end
  
end
