class Admin::UsersController < Admin::BaseController

  def index
     @users = User.tweets.(created_at: :desc)
  end
end
