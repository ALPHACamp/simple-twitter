class Admin::TweetsController < Admin::BaseController
  before_action :set_tweet, only: [:show, :destroy]

  def index
    @tweets = Tweet.all
  end

  def show
  end

  def destroy
    @tweet.destroy
    flash[:alert] = " Tweet was deleted successfully."
    redirect_to admin_root_path
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
