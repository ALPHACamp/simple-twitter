class Admin::UsersController < Admin::BaseController
  def index
    # 看見所有使用者
    @users = User.order(tweets_count: :desc)
  end
end
