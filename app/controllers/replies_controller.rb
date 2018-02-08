class RepliesController < ApplicationController

  def index
    @user = current_user
    @tweet = Tweet.find(params[:tweet_id])
    @replies = @tweet.replies
    @reply = Reply.new
  end

  def create
    @user = current_user
    @reply = Tweet.find(params[:tweet_id]).replies.build(reply_params)
    @reply.user = current_user
    @reply.save!

    redirect_to tweet_replies_url
  end

  private

  def reply_params
    params.require(:reply).permit(:comment)
  end
end
