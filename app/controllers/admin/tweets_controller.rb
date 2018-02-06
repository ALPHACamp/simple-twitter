class Admin::TweetsController < Admin::BaseController
  before_action :set_tweet ,only: [:destroy]

  def index
    @tweets = Tweet.all.page(params[:page]).per(10)
  end

  def destroy
    if current_user.admin?
      flash[:notice] = "Tweet by \"#{@tweet.user.name}\" was successfully deleted"
      @tweet.destroy
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = 'Not allow!'
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
