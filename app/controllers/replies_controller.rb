class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    # @user = User.find(@tweet.user_id)
    @user = current_user
    @replies = @tweet.replies.order(id: :desc).all

    @reply = current_user.replies.new
  end

  def create
    @reply = current_user.replies.new(reply_params)
    @reply.save
    redirect_to tweet_replies_path(current_user.replies.last.tweet_id)
  end

  private

  def reply_params
    params.require(:reply).permit(:tweet_id, :comment)
  end

end
