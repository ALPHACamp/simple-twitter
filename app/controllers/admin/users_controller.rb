class Admin::UsersController < Admin::BaseController
  def index
    @twiters = User.joins(:tweets).group("user_id").order("count(user_id) DESC")
  end
end
