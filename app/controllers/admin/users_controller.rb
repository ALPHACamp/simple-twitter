class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all

    @users.each do |user|
      user.count_tweets
    end

  end
end
