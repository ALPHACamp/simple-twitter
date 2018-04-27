class Admin::UsersController < Admin::BaseController
  def index
    @users=User.all.sort_by{|user| user.tweets.count}.reverse
  end
end
