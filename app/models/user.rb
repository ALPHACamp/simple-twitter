class User < ApplicationRecord
  validates_uniqueness_of :name
  mount_uploader :avatar, AvatarUploader

  has_many :tweets, dependent: :destroy

  has_many :replies, dependent: :restrict_with_error

  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user, counter_cache: true

  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  

 


  
  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end
end
