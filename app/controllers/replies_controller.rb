class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:id])
    @replies = @tweet.replies.all
    @reply = Reply.new
  end

  def create
    @tweet = current_user.replies.create(reply_params)
  end

  private

  def reply_params
    params.require(:reply).permit(:comment, :user_id, :tweet_id)
  end

end
