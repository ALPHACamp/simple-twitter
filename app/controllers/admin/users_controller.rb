class Admin::UsersController < Admin::BaseController
  
  def index
    @users = User.order(likes_count: :desc)

  end

end
