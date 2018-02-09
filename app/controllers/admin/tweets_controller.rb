class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.order(created_at: :desc).page(params[:page]).per(10)
    # @tweets = Tweet.all
  end

  def destroy
    Tweet.transaction do
      @tweet = Tweet.find(params[:id])
      user = @tweet.user.decrement(:tweets_count, 1)
      user.save
      @tweet.destroy
    end
    redirect_to admin_root_path
  end
end
