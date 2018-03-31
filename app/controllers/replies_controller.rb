class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @user = User.find(@tweet.user_id) #S15L1U3
    @replies = Reply.where(tweet_id: @tweet.id).order(created_at: :desc) # editing
    @reply = Reply.new
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @user = current_user
    @reply = Reply.new(reply_params)
    if @reply.save
      flash[:notice] = "reply was successfully created"
      redirect_to tweet_replies_path(@tweet)
    else
      redirect_to tweet_replies_path(@tweet)
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:tweet_id, :user_id, :comment)
  end

end
