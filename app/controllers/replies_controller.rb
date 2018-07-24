class RepliesController < ApplicationController

  def index
    @reply = Reply.find(params[:tweet_id])
    @replies = @reply.tweet.replies
    @tweet = Tweet.find(params[:tweet_id])
    @newReply = Reply.new
  end

  def create
    
  end

end
