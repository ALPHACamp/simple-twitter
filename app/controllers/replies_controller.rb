class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id]);
    @replies = Tweet.find(params[:tweet_id]).replies
    @user = Tweet.find(params[:tweet_id]).user
    @reply = Reply.new
  end

  def create
  end

end
