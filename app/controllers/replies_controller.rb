class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:id])
    @replies = @tweet.replies.order(created_at: :asc).all
    @reply = Reply.new
  end

  def create
    @reply = current_user.replies.create(reply_params)
    @tweet = @reply.tweet
  end

  private

  def reply_params
    params.require(:reply).permit(:comment, :user_id, :tweet_id)
  end

end
