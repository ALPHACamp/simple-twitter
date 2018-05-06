class RepliesController < ApplicationController
  before_action :set_tweet, only: [:index, :create]

  def index
    @replies = @tweet.replies.all
    @reply = Reply.new
  end

  def create
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user
    if @reply.save
      redirect_to tweet_replies_path(@tweet)
    else
      render :action => "index"
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
