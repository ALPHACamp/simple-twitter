class Admin::TweetsController < Admin::BaseController
  before_action :authenticate_admin


  def index
    @tweets = Tweet.page(params[:page]).per(10)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    render_to admin_tweets_path
    fiash[:alert] = "tweet was delete"
  end

    private

  def restaurant_params
    params.require(:tweet).permit(:name, :avatar, :introduction)
  end

end
