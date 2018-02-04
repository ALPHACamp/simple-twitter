class Admin::TweetsController < Admin::BaseController
  before_action :authenticate_user!
  # 後台權限驗證
  before_action :authenticate_admin
  
  def index
  end

  def destroy
  end
end
