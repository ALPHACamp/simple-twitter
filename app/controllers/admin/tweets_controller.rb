class Admin::TweetsController < Admin::BaseController
  
  # 建立使用者登入流程
  before_action :authenticate_user!

  # 建立管理者認證
  before_action :authenticate_admin

  def index
  end

  def destroy
  end
end
