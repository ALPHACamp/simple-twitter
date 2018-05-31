class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.all
    @replies = Reply.all

  end

  def destroy
    @tweet = Tweet.find(params[:id])

    if current_user.admin?
      @tweet.destroy
      redirect_back(fallback_location: root_path)
    end
  end
end
