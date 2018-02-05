class RepliesController < ApplicationController

  def index
    @user = current_user
    @reply = Reply.new
    

    @tweet = Tweet.find(params[:tweet_id])
    @tweets = Tweet.where(user_id: @user)
   
    @replies = Reply.where(tweet_id: @tweet)

    @user.likes_count = @user.likes.size
    @tweet.replies_count = @tweet.replies.size
    
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.new(reply_params)
    @reply.user = current_user
    @reply.save
    @tweet.replies_count = @tweet.replies.size
    @tweet.save
    redirect_to tweet_replies_path
  
  end




 private 

 def reply_params
   params.require(:reply).permit(:comment,:tweet_id)
 end


end


