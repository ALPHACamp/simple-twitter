class RepliesController < ApplicationController

  def index
  	@tweet = Tweet.find(params[:tweet_id])
  end

  def create
  end

end
