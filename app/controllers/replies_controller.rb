class RepliesController < ApplicationController
  before_action :fetch_tweet, only: [:index, :create]

  def index
    @user = @tweet.user
    @replies = @tweet.replies
    @reply = Reply.new
  end

  def create
    Tweet.transaction do
      @tweet = Tweet.find(params[:tweet_id])
      @reply = @tweet.replies.new(reply_params)
      @reply.user = current_user
      @reply.save!
    end
    redirect_to tweet_replies_path(@tweet)
  end

  private

  def fetch_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def reply_params
    params.require(:reply).permit(:comment)
  end
end
