class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :tweets
  has_many :replies
  has_many :likes
  has_many :liked_tweets, through: :likes, source: :tweet
  has_many :followships
  has_many :followings, through: :followships
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user


  def admin?
    self.role == "admin"
  end

  def update_count
    self.update(liked_tweets_count: self.tweets.sum(:likes_count))
  end

  def is_following?(user)
    self.followings.include?(user)
  end

end
