class RepliesController < ApplicationController

  def index
    @user = User.find(Tweet.find(params[:tweet_id]).user_id)
    @tweet = @user.tweets.find(params[:tweet_id])
  end

  def create
  end

end
