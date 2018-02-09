class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.all.order(created_at: :desc)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    flash[:notice] = "Admin功能: 已成功刪除該則tweet"
    redirect_back(fallback_location: admin_root_path)
  end
end
