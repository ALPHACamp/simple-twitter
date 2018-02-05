class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  # 需要 app/views/devise 裡找到樣板，加上 name 屬性
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  validates_presence_of :name
  validates :name, uniqueness:{scope: :name}
  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)

  has_many :tweets, dependent: :restrict_with_error

  has_many :likes, dependent: :destroy
  has_many :liked_tweet, through: :likes, source: :tweet


  has_many :replies, dependent: :restrict_with_error
  has_many :replied_tweet, through: :replies, source: :tweet

  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships, source: :user

  def admin?
    self.role == "admin"
  end

end
