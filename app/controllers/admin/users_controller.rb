class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(tweets_count: :desc)
    #rspec 會有錯，要用@user = User.all才會對
  end
end
