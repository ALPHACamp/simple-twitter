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
  has_many :tweets

  # 一個user可以有很多條回覆的comment
  has_many :replies, through: :tweets

  # 一個user可以主動擁有很多個followship
  has_many :followships, dependent: :destroy
  # 透過followship，一個user可以follow很多其他user
  has_many :followings, through: :followships


  def admin?
    self.role == "admin"
  end

  def is_following?(user)
    self.followings.include?(user)
  end

end
