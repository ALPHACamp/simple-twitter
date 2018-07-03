class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @replies = @tweet.replaies.all.order(created_at: :desc)
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.new(reply_params)
    @reply.user = current_user
    @reply.save!
    redirect_to tweet_replies_path(@reply)
  end


private

  def reply_params
    params.requires(:reply).permit(:comment)
  end


end
