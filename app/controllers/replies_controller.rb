class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @replies = @tweet.replies.order(created_at: :desc)
    @reply = @tweet.replies.new
  end

  def create
  end

end
