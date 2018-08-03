class Admin::UsersController < Admin::BaseController
 # 後台登入先確認user登入再確認身份為admin，authenticate_admin方法要另外定義
before_action :authenticate_user!
before_action :authenticate_admin 
  def index
    @users =  User.order(tweets_count: :desc)
  end
end
