class RepliesController < ApplicationController

  def index

    @tweet = Tweet.find(params[:tweet_id])
    @replies = @tweet.replies
    @reply = Reply.new
    @user = @tweet.user
     
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user
    

    if @reply.save 
      flash[:notice] = "reply successfully"
      redirect_to tweet_replies_path
    else
      flash[:alert] = "fail to reply the tweet"
      render :index
    end
  end

  private
  def reply_params
    params.require(:reply).permit(:comment, :user_id, :tweet_id)
  end

end
