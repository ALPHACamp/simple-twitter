class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @user = @tweet.user
    @reply = Reply.new
    @replies = Reply.where('tweet_id' => params[:tweet_id])
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.create(reply_params)
    @reply.user = current_user
    @reply.save!
    redirect_to tweet_replies_path
  end

  private

  def reply_params
    params.require(:reply).permit(:comment)
  end
  

end
