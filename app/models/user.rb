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

  has_many :tweets, dependent: :restrict_with_error

  #like
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet
  

  #reply
  has_many :replies, dependent: :destroy

  #followship
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id", counter_cache: true
  has_many :followers, through: :inverse_followships, source: :user


  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end

  def count_followings
    self.followings_count = self.followings.size
    self.save
  end

  def count_followers
    self.followers_count = self.followers.size
    self.save
  end

end
