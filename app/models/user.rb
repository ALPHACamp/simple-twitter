class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  # 需要 app/views/devise 裡找到樣板，加上 name 屬性
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  # 讓 name 爲必填欄位
  validates_presence_of :name
  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)
  # 這樣似乎是能讓網頁跳出 error，但是似乎不太理想
  # validates :name, uniqueness: {scope: :id}
  # 這個是到 api.rubyonrails.org 查到的
  validates_uniqueness_of :name

  # 檢查是否爲網站管理員
  def is_admin?
    if self.role == "admin"
      return true
    end
  end
end
