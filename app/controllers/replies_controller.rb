class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @user = @tweet.user
    @replies = @tweet.replies
    @reply = Reply.new

    render :nothing => true
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user
    @reply.save!
    redirect_to tweet_replies_path(@tweet)
  end

  private

  def reply_params
    params.require(:reply).permit(:comment, :tweet_id, :user_id)
  end
end
