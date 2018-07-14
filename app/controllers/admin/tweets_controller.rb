class Admin::TweetsController < Admin::BaseController
  before_action :authenticate_user!
  before_action :authenticate_admin


  def index
    @tweets= Tweet.order(created_at: :desc)
    #@tweets=Tweet.all
    @user=current_user
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    @user=@tweet.user
    @user.update(:tweets_count => @user.tweets.count)
    @user.save!
    redirect_to admin_root_path
    flash[:alert] = "tweet was deleted"
  end
end
