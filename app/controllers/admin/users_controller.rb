class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all.sort { |x,y| x.tweets.size <=> y.tweets.size }
  end
end
