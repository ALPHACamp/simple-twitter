class Admin::TweetsController < Admin::BaseController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @tweets = Tweet.page(params[:page]).per(10)
  end

  def destroy
  end
end
