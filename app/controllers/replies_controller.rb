class RepliesController < ApplicationController
  before_action :set_tweet

  def index
    @user = @tweet.user
    @replies = @tweet.replies
    @reply = Reply.new

    render 'index'
  end

  def create
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
    params.require(:reply).permit(:comment, :tweet_id, :user_id)
  end
end
