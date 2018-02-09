class RepliesController < ApplicationController
  before_action :set_tweet, only: [:index, :create]

  def index
    # 透過tweet_replies_path(tweet)傳入個別tweet資料
    # 去找到tweet的相關資訊(作者/回覆)
    #@tweet = Tweet.find(params[:tweet_id])
    @replies = @tweet.replies
    @reply = Reply.new
  end

  def create
    #@tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user
    @reply.save!
    redirect_to tweet_replies_path(@tweet)    
  end

  private 
  
  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
  def reply_params
    params.require(:reply).permit(:comment)
  end
end
