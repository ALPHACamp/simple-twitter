class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.all
  end

  def destroy
  end
end
