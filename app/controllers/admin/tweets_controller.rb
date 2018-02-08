class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.all
  end

  def destroy
    Tweet.find(params[:id]).destroy
    redirect_back(fallback_location: admin_root_path)
  end
end
