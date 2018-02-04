class RepliesController < ApplicationController

  def index
    @reply = Reply.new
    @tweet = Tweet.find(params[:tweet_id])
  end

  def create
    @reply = Reply.new(reply_params)
    @tweet = Tweet.find(params[:tweet_id])
    @user = User.find(params[:user_id])
    @comment.user = current_user
    @comment.save!
    redirect_to tweet_path(@tweet)
  end

  private

  def reply_params
    params.require(:reply).permit(:comment)
  end

end
