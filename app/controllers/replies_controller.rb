class RepliesController < ApplicationController

  def index
    @reply = Reply.find(params[:tweet_id])
    @replies = @reply.tweet.replies.order(created_at: :desc)
    @tweet = Tweet.find(params[:tweet_id])
    @newReply = Reply.new
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
