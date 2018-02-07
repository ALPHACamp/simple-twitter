class Admin::TweetsController < Admin::BaseController
  def index
    # @users = User.all
    @tweets = Tweet.all
    @replies = Reply.all
  end

  def destroy
  end
end
