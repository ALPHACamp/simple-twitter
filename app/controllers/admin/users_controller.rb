class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(self.tweets.size :desc)
  end
end
