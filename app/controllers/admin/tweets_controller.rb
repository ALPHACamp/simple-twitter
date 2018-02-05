class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.order(created_at: :desc)
    @users = User.all
  end

  def destroy
  end
end
