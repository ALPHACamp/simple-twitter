class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @user = @tweet.user
    @replies = @tweet.replies.order(update_at: :desc)
    @reply = Reply.new
  end

  def create
    tweet = Tweet.find(params[:tweet_id])
    reply = tweet.replies.create(reply_params)
    reply.user = current_user
    repy.save
    redirect_to tweet_replies_path(tweet)
  end

  private

  def reply_params
    params.require(:reply).permit(:comment)
  end
  

end
