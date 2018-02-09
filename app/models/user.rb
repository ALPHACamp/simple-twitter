class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tweets, dependent: :destroy
  # followships
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships
  # inverse_followships
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user
  # likes
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet

  
  mount_uploader :avatar, AvatarUploader

  validates :name, :presence => true, :uniqueness => true

  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end

end
