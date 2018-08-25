class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  # 一個 user 可以有多則 tweet
  has_many :tweets

  # 一個 user 可以有多則 reply
  has_many :replies, through: :tweets

  # 一個 user 可以 like 多則 tweet
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet

  # 一個使用者可以追蹤多個其他使用者, 刪除使用者時連同追蹤紀錄一起刪除
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  # 需要 app/views/devise 裡找到樣板，加上 name 屬性
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  validates_presence_of :name
  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)
  validates_uniqueness_of :name

  # admin? 讓我們用來判斷單個user是否有 admin 角色，列如：current_user.admin?
  def admin?
    self.role == "admin"
  end

  # 檢查 current_user與另一個user物件，在 followships table 上查詢，看看是否有已經存在的紀錄
  def followship?(user)
    self.followships.include?(user)
  end

end
