class Admin::TweetsController < Admin::BaseController
# 後台登入先確認user登入再確認身份為admin，authenticate_admin方法要另外定義
before_action :authenticate_user!
before_action :authenticate_admin
  def index
    @tweets = Tweet.all #管理者瀏覽所有tweet資料
  end

  def destroy
  end
end
