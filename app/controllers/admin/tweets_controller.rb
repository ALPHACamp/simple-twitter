class Admin::TweetsController < ApplicationController
  before_action :authenticate_admin

  def index
    @tweets = Tweet.page(params[:page]).per(10)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to admin_tweets_path
    flash[:alert] = "推文已刪除"
  end

  private

    def authenticate_admin
      unless current_user.admin?
        flash[:alert] = "非工作人員請勿進入!"
        redirect_to root_path
    end
  end
end
