class Admin::UsersController < Admin::BaseController
  def index
    @users = User.where.not(role: "admin").all
  end
end
