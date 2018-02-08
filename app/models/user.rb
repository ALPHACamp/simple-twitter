class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tweets
  # followships
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships
  # inverse_followships
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

  mount_uploader :avatar, AvatarUploader

  validates :name, :presence => true, :uniqueness => true

  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end

end
