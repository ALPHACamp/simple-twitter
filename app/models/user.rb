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

  # 當 user 被刪除時，順便刪除依賴的 tweets
  has_many :tweets, dependent: :destroy

  has_many :replies

  # 使用者的followships資料
  has_many :followships, dependent: :destroy
  # 此使用者追蹤的人
  has_many :followings, through: :followships


  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end

end
