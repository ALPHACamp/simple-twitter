class Admin::TweetsController < Admin::BaseController
  before_action :authenticate_user!
  
  def index

  end

  def destroy
  end
end
