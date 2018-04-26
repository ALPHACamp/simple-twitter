class Admin::TweetsController < Admin::BaseController
  before_action :authenticate_admin  #驗證身份是否為admin
  
  def index
  end

  def destroy
  end
end
