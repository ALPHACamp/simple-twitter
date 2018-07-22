class Admin::TweetsController < Admin::BaseController
  before_action :authenticate_admin

  def index
    @tweets = Tweet.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def destroy
  end
end
