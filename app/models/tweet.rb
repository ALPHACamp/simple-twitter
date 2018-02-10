class Tweet < ApplicationRecord
  attr_accessor :description
  validates_length_of :description, maximum: 140
  
  belongs_to :user, optional: true #一個tweet屬於一個使用者 

  has_many :likes, dependent: :destroy #一個tweet可以有很多like
  has_many :liked_users, through: :likes, source: :user 
  #一個tweet，被like的使用者，關聯昰like

  has_many :replies, dependent: :destroy #一個user可以有很多replies
  has_many :replied_users, through: :replies, source: :user 
  #一個user，被reply的user，關聯昰user 

  @tws=Tweet.all
  @tws.each do |tweet|
   @replies_count=tweet.replies.count
   @likes_count=tweet.likes.count
   @tweet=Tweet.update(tweet.id,replies_count: @replies_count,tweet.id,likes_count: @likes_count)
   @tweet.save!
  end 
end
