class RepliesController < ApplicationController

  before_action :set_tweet

  def index
    @replies = @tweet.replies.all
    @reply = Reply.new
    @user = @tweet.user
  end

  def create
    @reply = @tweet.replies.build(comment: reply_params[:comment], user: current_user)
    if @reply.save
      redirect_to tweet_replies_path(@tweet), notice: "reply success"
    else
      redirect_back fallback_location: root_path
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
