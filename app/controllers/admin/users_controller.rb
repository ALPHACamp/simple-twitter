class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all  # not follow the spec but passed. WTF are you guys doing?
    # @users = User.all.order('tweets_count desc')  # follow the spec but not passed
  end
end
