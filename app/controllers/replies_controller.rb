class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @user = User.find(@tweet.user_id) #S15L1U3
    @replies = Reply.where(tweet_id: @tweet.id).order(created_at: :desc) # editing
  end

  def create
    @user = current_user
    @tweet = Tweet.find(params[:tweet_id])
    @reply = Reply.new(reply_params)
    @reply.save
    @tweet.increment!(:replies_count)
    flash[:notice] = "reply was successfully created"

    redirect_to replies_path
  end

  private

  def reply_params
    params.require(:reply).permit(:tweet_id, :user_id, :comment)
  end

end
