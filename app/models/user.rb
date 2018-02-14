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
  

  has_many :tweets, dependent: :destroy #一個user可以有很多tweet

  has_many :likes, dependent: :destroy #一個user可以有很多like
  has_many :liked_tweets, through: :likes, source: :tweet 
  #一個user，被like的tweet，關聯昰tweet

  has_many :replies, dependent: :destroy #一個user可以有很多replies
  has_many :replied_tweets, through: :replies, source: :tweet 
  #一個user，被reply的tweet，關聯昰tweet 

  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships  

  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user 

  def admin?
   self.role == "admin"
  end
  
  def following?(user)
    self.followings.include?(user)
  end  
  
  @usrs=User.all
  @usrs.each do |user|
   @likes_count=user.likes.count
   @user=User.update(user.id,likes_count: @likes_count)
   @user.save!
  end

  @usrs=User.all
  @usrs.each do |user|
   @followers_count=user.followers.count
   @user=User.update(user.id,followers_count: @followers_count)
   @user.save!
  end  

end
