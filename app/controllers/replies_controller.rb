class RepliesController < ApplicationController

  def index
    #reply 時應該出現的會是自己的狀態
  @tweet = Tweet.find(params[:id]) 
  @replies = Reply.new
  end

  def create
   @tweet = Tweet.find(params[:id])
   @replies = @tweet.replies.build(reply_params)
   @replies.user = current_user
   @replies.save!
   @tweet.count_replies  
   redirect_to replies_tweet_path(@tweet)
  end
private

  def reply_params
    params.require(:reply).permit(:comment)    
  end
end
