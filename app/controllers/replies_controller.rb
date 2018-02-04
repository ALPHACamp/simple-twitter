class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @reply = Reply.new
    @replies = Reply.where(tweet_id: @tweet)
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.new(reply_params)
    @reply.user = current_user
    @reply.save
    redirect_to tweet_replies_path
   
  end




 private 

 def reply_params
   params.require(:reply).permit(:comment,:tweet_id)
 end


end


