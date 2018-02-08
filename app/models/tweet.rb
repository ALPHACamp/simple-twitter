class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  default_scope { order(created_at: :desc) }
  belongs_to :user, counter_cache: true
  #tweet只能有一個作者

  has_many :replies, dependent: :destroy
  #刪掉tweet 就會刪掉reply

  has_many :likes, dependent: :destroy
  #刪掉tweet 就會刪掉like
  has_many :liked_users, through: :likes, source: :user



  def is_liked?(user)
    self.liked_users.include?(user)
  end

  def like_at(user)
    if self.liked_users.include?(user)
      like = self.likes.find_by(user_id: user.id)
      return like.created_at
    else
      return "no like"
    end
  end
end


      