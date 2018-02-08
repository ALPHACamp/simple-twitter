class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  has_many :tweets, dependent: :destroy
  has_many :replies, dependent: :destroy

  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  has_many :inverse_followship, class_name: "Followship", foreign_key: "following_id"
  has_many :follower, through :inverse_followship, source :user


  # 需要 app/views/devise 裡找到樣板，加上 name 屬性
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  validates_presence_of :name
  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)
  validates :name, uniqueness: true

  def admin?
    self.role == "admin"
  end

  def is_following?(user)
    self.followings.include?(user)
  end

end
