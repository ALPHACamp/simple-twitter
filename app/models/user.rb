class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  has_many :tweets
  has_many :likes, dependent: :destroy            #favorite存在時，刪除user會將favorite一併刪除
  has_many :likes_tweets, through: :likes, source: :tweet

  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships
  #定義與followship相反方向的方法
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user
  has_many :replies

  # 需要 app/views/devise 裡找到樣板，加上 name 屬性
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  validates_presence_of :name
  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)

  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end

end
