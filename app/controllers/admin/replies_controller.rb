class Admin::RepliesController < Admin::BaseController
  def index
    @tweet = Tweet.find(params[:tweet_id]) #確認推播物件
    @replies = @tweet.replies.all
  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @reply = Reply.find(params[:id])
    @reply.destroy
    redirect_to admin_tweet_replies_path
    flash[:alert] = "reply deleted"
  end
end