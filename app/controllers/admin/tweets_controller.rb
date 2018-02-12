class Admin::TweetsController < Admin::BaseController
  def index
    # @users = User.all
    @tweets = Tweet.order("tweets.created_at desc").all
    @replies = Reply.order("replies.created_at desc").all
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to admin_tweets_path
  end
end
