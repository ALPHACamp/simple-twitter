class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @reply = Reply.new
    @replies = @tweet.replies.order(created_at: :desc)
    @user = @tweet.user
    
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.new(reply_params)
    @reply.user = current_user
    if @reply.save
      redirect_to tweet_replies_path(@tweet)
    else
      flash[:alert] = "Comments can't be blank!"
      redirect_back(fallback_location: request.referrer)
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:comment)
  end

end
