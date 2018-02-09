class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @replies = @tweet.replies.order(created_at: :desc)
    @reply = @tweet.replies.new
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user
    @reply.save!
    flash.notice = "回覆推播成功！"
    redirect_to tweet_replies_path(@tweet)
  end

  private

  def reply_params
    params.require(:reply).permit(:comment)
  end


end
