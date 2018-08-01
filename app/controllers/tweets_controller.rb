class TweetsController < ApplicationController
  
  
  def index
    @tweets = Tweet.all
    @users = User.all.order(follower_count: :desc).limit(10)
    @tweet = Tweet.new
  end
end
