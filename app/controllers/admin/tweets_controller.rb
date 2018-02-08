class Admin::TweetsController < Admin::BaseController

  #是否已登入
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
  end

  def destroy
  end
end
