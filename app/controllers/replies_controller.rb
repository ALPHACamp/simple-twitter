class RepliesController < ApplicationController

  def index
    @reply = Reply.new
    @tweet = Tweet.find(params[:tweet_id])
    @replies = @tweet.replies.all.order(created_at: :desc)
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user
    @reply.save!
    flash[:notice] = "已reply一則tweet"
    redirect_to tweet_replies_path

  end

private
  
  def reply_params
    params.require(:reply).permit(:comment)
  end

end
