class Admin::TweetsController < Admin::BaseController
  def index
    @users = User.all
    @tweets = Tweet.all
  end

  def destroy
  end
end
