class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  # 需要 app/views/devise 裡找到樣板，加上 name 屬性
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  validates_presence_of :name
  validates :name, uniqueness: true
  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)
  has_many :tweets, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships, dependent: :destroy
  has_many :followed, class_name: "Followship" , foreign_key: :following_id
  has_many :followers, through: :followed, source: :user
  has_many :likes, dependent: :destroy
  has_many :like_tweets, through: :likes, source: :tweet

  def admin?
    return true if self.role == "admin"
  end

  def follow?(following_id)
    return true if self.followships.where(following_id: following_id).first != nil
  end

  def like?(tweet_id)
    return true if self.likes.where(tweet_id: tweet_id).first != nil
  end

  def tweet?(tweet_id)
    return true if self.tweets.find_by(id: tweet_id) != nil
  end

  def count_tweets
    self.tweets_count = self.tweets.size
    self.save
  end

end
