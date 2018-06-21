class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  # 需要 app/views/devise 裡找到樣板，加上 name 屬性

  validates_presence_of :name
  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)
  validates_uniqueness_of :name

  has_many :tweets, dependent: :destroy

  has_many :replies,dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet

  has_many :followships,dependent: :destroy, class_name: "Followship", foreign_key: "user_id" 
  has_many :followings,through: :followships,source: :following
 
  has_many :inverse_followships,dependent: :destroy,class_name: "Followship", foreign_key: "following_id" 
  has_many :followers,through: :inverse_followships,source: :user 

  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end
  
end

