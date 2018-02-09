class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id]);
    @replies = Tweet.find(params[:tweet_id]).replies
    @user = Tweet.find(params[:tweet_id]).user
  end

  def create
  end

end
