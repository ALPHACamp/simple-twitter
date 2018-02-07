class RepliesController < ApplicationController

  #replies是點擊某則tweets後出現的頁面
  def index
    @tweet = Tweet.find(params[:tweet_id])
    @reply = Reply.new
  end

  #編輯完回覆，replays
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user
    @reply.save!
    redirect_to tweet_replies_path(@tweet)
  end

  private

  def reply_params
    params.require(:reply).permit(:comment)
  end

end
