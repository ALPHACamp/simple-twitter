class Admin::UsersController < Admin::BaseController
  def index
    @users = User.joins(:tweets).group("users.id").order("count(users.id) DESC")

    #@user.followings.includes(:followships).order("followships.created_at DESC")
  end



end
