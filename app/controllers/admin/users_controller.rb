class Admin::UsersController < Admin::BaseController

  # S16L1U2 有最近十筆排序 參考一下
  def index
    @users = User.all.includes(:tweets, :likes, :followships).order(tweets_count: :desc)
  end
end
