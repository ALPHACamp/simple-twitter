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
  has_many :tweets
  has_many :replies
  has_many :followships
  has_many :followings, through: :followships
  has_many :followed, class_name: "Followship" , foreign_key: :following_id
  has_many :followers, through: :followed, source: :user
  has_many :likes

  def admin?
    return true if self.role == "admin"
  end

end
