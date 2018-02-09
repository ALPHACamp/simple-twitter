class Admin::TweetsController < Admin::BaseController
  def index
  @tweets = Tweet.all
  @reply_all = Reply.all
  end

  def destroy
    @tweet_id = Tweet.find(params[:id])
    @tweet_id.destroy
    redirect_to admin_root_path
  end

    def reply
      $whole_area_tweet_id = Tweet.find(params[:id])
      redirect_to admin_tweets_path
    end
end
