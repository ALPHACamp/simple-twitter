class RepliesController < ApplicationController

  def index
    @tweet   = Tweet.find(params[:tweet_id])
    @user    = @tweet.user
    @replies = @tweet.replies.order(created_at: :asc)
    @reply   = current_user.replies.new
  end

  def create
    @tweet   = Tweet.find(params[:tweet_id])
    @reply   = @tweet.replies.new(reply_params)
    @reply.user = current_user

    if @reply.save
      flash[:notice] = "reply was successfully created"
      redirect_to tweet_replies_path(params[:tweet_id])
    else
      # @tweet = Category.all
      render :index
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:comment)
  end
end
