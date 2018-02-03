class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all     # S16L1U2 有最近十筆排序 參考一下
  end
end
