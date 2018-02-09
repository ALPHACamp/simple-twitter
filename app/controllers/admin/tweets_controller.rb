class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.order(created_at: :desc)
  end

  def destroy
    Tweet.find(params[:id]).destroy
    redirect_back(fallback_location: admin_root_path)
  end
end
