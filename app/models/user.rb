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

  #following 可以從user取得 自己追蹤的人
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships 
  #指回following，user.following指這個user正在追蹤的人(following)

  #follower 可以從user取得 追蹤自己的人
  has_many :inverse_followships, class_name:"Followship", foreign_key:"following_id"
  has_many :followers, through: :inverse_followships, source: :user
  #先自建一個inverse followships，指定followship model的following_id (對USER來說 USER是PK，指去followship的FK是following_id)

  has_many :tweets, dependent: :destroy
  has_many :replies, dependent: :destroy

end
