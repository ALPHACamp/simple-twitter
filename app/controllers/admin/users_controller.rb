class Admin::UsersController < Admin::BaseController

  # S16L1U2 有最近十筆排序 參考一下
  def index
    @users = User.all
    # @users = User.all.order(user.tweets.count :desc) # 無效版
    # @user = User.left_joins(:tweets).group(:id).order('COUNT(tweets.id) DESC') # 依然無效，剩加欄一途。
    
  end
end
