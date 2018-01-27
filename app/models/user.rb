class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :tweets, dependent: :destroy
  has_many :replies, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :like_tweets, through: :likes, source: :tweet
end
