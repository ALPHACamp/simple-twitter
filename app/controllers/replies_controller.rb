class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @reply = Reply.new
    @replies = Reply.all
  end

  def create
    @reply = Reply.new(reply_params)
    @reply.save
    redirect_to tweet_replies_path
   
  end




 private 

 def reply_params
   params.require(:reply).permit(:comment,:tweet_id)
 end


end


