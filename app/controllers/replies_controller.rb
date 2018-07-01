class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @replies = @tweet.replies
    @user = @tweet.user
    
  end

  def create
  end

  private

  def reply_params
    params.require(:reply).permit(:comment)
  end

end
