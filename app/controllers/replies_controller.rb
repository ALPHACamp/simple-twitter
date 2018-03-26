class RepliesController < ApplicationController
  before_action :set_tweet, only:[:index]

  def index
    @user = @tweet.user
  end

  def create
  end

 private

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

end
