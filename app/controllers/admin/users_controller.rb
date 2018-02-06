class Admin::UsersController < Admin::BaseController
  def index
    @users = User.where.not(role: "admin").order(:id)
  end
end
