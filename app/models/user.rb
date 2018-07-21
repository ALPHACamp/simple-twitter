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
  validates :email, :name, uniqueness: true
  
  # 一個使用者有多個推播
  has_many :tweets, dependent: :destroy

  # 使用者可like多個推播
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet

  # 一個使用者有多個回覆
  has_many :replies, dependent: :destroy

  # 一個 User 擁有很多追蹤紀錄，透過追蹤紀錄，一個 User 追蹤很多其他 User (followings)
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  # 一個 User 擁有很多被追蹤紀錄，透過被追蹤紀錄，一個 User 被很多其他 User 追蹤 (followers)
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

  # 驗證admin方法
  def admin?
    self.role == "admin"
  end

  # 計算like數量
  def count_likes
    self.likes_count = self.likes.size
    self.save
  end

  # 檢查是否有追蹤紀錄
  def following?(user)
    self.followings.include?(user)
  end

end
