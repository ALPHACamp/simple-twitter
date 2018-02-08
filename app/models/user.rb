class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  # 需要 app/views/devise 裡找到樣板，加上 name 屬性      V
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法   V
  validates_uniqueness_of :name
  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)   V
  
  validates_length_of :introduction, maximum: 200
  

  has_many :replies, dependent: :destroy
  has_many :tweets, through: :replies, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet

  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships


  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id", dependent: :destroy
  has_many :followers, through: :inverse_followships, source: :user


  def is_following?(user)
    self.followings.include?(user)
  end

end
