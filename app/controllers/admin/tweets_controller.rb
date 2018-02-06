class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.order(created_at: :desc)
  end

  def destroy
  end
end
