class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.order(created_at: :DESC)
  end

  def destroy
  end
end
