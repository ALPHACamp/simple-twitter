class Admin::TweetsController < Admin::BaseController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @tweets = Tweet.all
    @users = User.all     # S16L1U2 有最近十筆排序 參考一下
  end

  def destroy
  end
end
