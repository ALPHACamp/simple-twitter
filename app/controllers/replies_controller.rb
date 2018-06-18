class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id]) #確認推播物件
    @user = @tweet.user
    @reply = @tweet.replies.new
    @replies = @tweet.replies.all.order(created_at: :asc)
  end

  def create
    @tweet = Tweet.find(params[:tweet_id]) #確認推播物件
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user #重要
    @reply.save
    redirect_to tweet_replies_path(@tweet)
  end

  private

  def reply_params
    params.require(:reply).permit(:comment)
  end

end
