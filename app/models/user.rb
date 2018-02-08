class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  # 需要 app/views/devise 裡找到樣板，加上 name 屬性
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法

  # validates :name, presence: true
  validates_presence_of :name, length: { maximum: 20 }, :uniqueness => { case_sensitive: false }
  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)

  has_many :tweets, dependent: :restrict_with_error


  has_many :replies, dependent: :destroy
  has_many :replied_tweets, through: :replies, source: :tweets

  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweets


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

  def liked_tweets_count
    # tweets_count = self.tweets.count
    # followings_count = self.followings.count
    # followers_count = self.followers.count
    likes_count = self.likes_count
    liked_tweets_count = self.tweets.sum(:likes_count)
  end
end
