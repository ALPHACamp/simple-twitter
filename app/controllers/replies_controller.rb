class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @replies = Tweet.find(params[:tweet_id]).replies.order(created_at: :asc)
    @user = Tweet.find(params[:tweet_id]).user
    @reply = Reply.new
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user
    @reply.save!
    redirect_to tweet_replies_path(@tweet.id)
  end
  
  private
  
  def reply_params
    params.require(:x).permit(:comment)
  end

end
