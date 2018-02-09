class RepliesController < ApplicationController

  before_action :set_tweet
  def index
      #@tweet = Tweet.find(params[:tweet_id])
      @replies = @tweet.replies.all
      @reply = Reply.new
  end

  def create
     #@tweet = Tweet.find(params[:tweet_id])
     @reply = @tweet.replies.build(comment: reply_params[:comment], user: current_user)
     
    if @reply.save
      
     # @replies = @tweet.replies.all
      flash[:notice] = "Successfully replied"
      redirect_to tweet_replies_url
      
    else
      flash.now[:alert] = @reply.errors.full_messages.to_sentence if @reply.errors.any?
      redirect_back(fallback_location: tweet_replies_url)  # 導回上一頁
      #@tweets = Tweet.all
      #render :index
    end  
    
  end
  
  private
  
  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
  
  def reply_params
    params.require(:reply).permit(:comment)
  end

end
