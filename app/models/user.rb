class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader
  has_many :tweets
  has_many :replies
  has_many :likes

  #自關聯
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  # 逆向自關聯
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

  # 需要 app/views/devise 裡找到樣板，加上 name 屬性
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  validates_presence_of :name
  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)
  validates_uniqueness_of :name

  def admin?
    self.role == "admin" #回傳布林值
  end

  def following?(user)
    self.followings.include?(user)
  end

  def followers_plus
    self.followers_count ||= 0
    self.followers_count += 1
    self.save
  end

  def followers_minus
    self.followers_count ||= 0
    self.followers_count -= 1
    self.save
  end

end
