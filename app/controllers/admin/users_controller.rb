class Admin::UsersController < Admin::BaseController
  before_action :authenticate_admin
  def index
  end
end
