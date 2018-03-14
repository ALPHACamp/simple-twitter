class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @replies = @tweet.replies.order(updated_at: :desc)
    @reply = Reply.new

  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.create(replies_params)
    @reply.user = current_user
    @reply.save
    redirect_back(fallback_location: root_path)
  end

  private

  def replies_params
    params.require(:reply).permit(:comment)
  end


end
