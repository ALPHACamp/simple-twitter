class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.all.order(created_at: :desc)
  end

  def destroy
  end
end
