class RepliesController < ApplicationController

  def index
    @user = current_user
    @tweet = Tweet.find(params[:tweet_id])
    @reply = Reply.new
    @replies = @tweet.replies.all.order(created_at: :desc)
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
    params.require(:reply).permit(:comment)
  end


end
