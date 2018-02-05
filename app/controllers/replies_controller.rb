class RepliesController < ApplicationController

  def index
  	@tweet = Tweet.find(params[:tweet_id])
  	@user = @tweet.user
  end

  def create
  end

end
