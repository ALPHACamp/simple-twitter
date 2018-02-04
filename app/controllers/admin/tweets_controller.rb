class Admin::TweetsController < Admin::BaseController
  def index
    @tweets = Tweet.order(created_at: :desc).page(params[:page]).per(9)
  end

  def destroy
  end
end
