class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  # 需要 app/views/devise 裡找到樣板，加上 name 屬性
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  validates_presence_of :name
  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)
  validates_uniqueness_of :name

  # 一個user可以有很多則tweet
  has_many :tweets, dependent: :destroy

  # 一個user可以有很多條回覆的comment
  has_many :replies, through: :tweets


  # 一個user可以主動擁有很多個followship & + 用order排序followship更新時間達到followings以最新followship排序
  has_many :followships,-> { order('followships.created_at DESC') }, dependent: :destroy
  # 透過followship，一個user可以follow很多其他user
  has_many :followings, through: :followships

  # 一個follower可以有很多個followship & + 用order排序followship更新時間達到followers以最新followship排序
  has_many :inversed_followships,-> { order('followships.created_at DESC') }, class_name: "Followship", primary_key: "id", foreign_key: "following_id"
  # 透過followship，一個user可以有很多follower
  has_many :followers, through: :inversed_followships, source: :user

  # 一個user可以有很多like
  has_many :likes, -> { order('likes.created_at DESC') }, dependent: :destroy
  # 透過like，一個user可以like很多tweets
  has_many :liked_tweets, through: :likes, source: :tweet


  def admin?
    self.role == "admin"
  end

  def is_following?(user)
    self.followings.include?(user)
  end

  def liked_tweet?(tweet)
    self.liked_tweets.include?(tweet)
  end

end
