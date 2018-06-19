class Admin::TweetsController < Admin::BaseController
  def index
    @recent_tweets = Tweet.order(created_at: :desc)
  end

  def destroy
  end
end
