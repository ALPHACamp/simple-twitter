class RepliesController < ApplicationController

  before_action :get_tweet, only: [:index, :create]
  def index
    @replies = @tweet.replies
    @reply = Reply.new
    @user = @tweet.user
  end

  def create
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user
    if !@reply.save
      flash[:alert] = @reply.errors.full_messages.to_sentence
    end
    redirect_to tweet_replies_path(@tweet)
  end

  private

  def get_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def reply_params
    params.require(:reply).permit(:comment)
  end
end
