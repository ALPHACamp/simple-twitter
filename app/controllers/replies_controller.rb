class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @replies = @tweet.replies 
    @user = @tweet.user
  end

  def create
  end

end
