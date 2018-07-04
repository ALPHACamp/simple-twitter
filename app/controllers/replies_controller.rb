class RepliesController < ApplicationController
  before_action :set_tweet
  def index
    # set tweet
    @replies = @tweet.replies.order(created_at: :desc)
    @reply = @tweet.replies.build
  end   

  def create
    # seet tweet
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user
    
    if @reply.save(reply_params)
      redirect_to tweet_replies_path(@tweet)
    else
      flash[:alert] = @reply.errors.full_messages.to_sentence
      redirect_to tweet_replies_path(@tweet) 
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

