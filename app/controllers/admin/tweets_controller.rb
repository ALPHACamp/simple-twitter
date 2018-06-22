class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.order(created_at: :desc)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    flash[:notice]="已成功刪除該推特"
    redirect_to admin_root_path
  end
end
