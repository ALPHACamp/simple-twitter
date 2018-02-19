class Admin::TweetsController < Admin::BaseController
  
  # 建立使用者登入流程
  before_action :authenticate_user!

  # 建立管理者認證
  before_action :authenticate_admin

  # 可看全部的推播
  def index
  	@tweets = Tweet.all
  end

  def destroy
  end
end
