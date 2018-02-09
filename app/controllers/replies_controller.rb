class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @user = User.find(@tweet.user_id)
    @replies = @user.replies.where(tweet_id: @tweet.id)
    
    @reply = current_user.replies.new
  end

  def create
    @reply = current_user.replies.new(reply_params)
    @reply.save
    redirect_to tweet_replies_path(current_user.replies.last.tweet_id)
  end

  private

  def reply_params
    params.require(:reply).permit(:tweet_id, :comment)
  end

end
