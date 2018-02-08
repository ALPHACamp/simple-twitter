class Admin::TweetsController < Admin::BaseController
  before_action :set_tweet ,only: [:destroy]

  def index
    @tweets = Tweet.all.includes(:user, :liked_users, :replies => :user).order('created_at desc')
  end

  def destroy
    flash[:notice] = "Tweet by \"#{@tweet.user.name}\" was successfully deleted"
    @tweet.destroy
    redirect_to admin_root_path
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
