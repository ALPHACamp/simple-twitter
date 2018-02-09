class Tweet < ApplicationRecord

  validates_length_of :description, maximum: 140
  validates_presence_of :description


  belongs_to :user, counter_cache: true

  has_many :replies, dependent: :destroy

  # has_many :replied_users, through: :replies, source: :user

  has_many :likes, dependent: :destroy

  has_many :liked_users, through: :likes, source: :user


  # def is_replied?(user)
  #   self.replied_users.include?(user)
  # end

  def is_liked?(user)
    self.liked_users.include?(user)
  end

  # def like_at(user)
  #    if self.liked_users.include?(user)
  #      like = self.likes.find_by(user_id: user.id)
  #      return like.created_at
  #    else
  #      return "no like"
  #    end
  #  end



end
