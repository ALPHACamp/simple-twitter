class Admin::TweetsController < Admin::BaseController
  def index
    @users = User.all
  end

  def destroy
  end
end
