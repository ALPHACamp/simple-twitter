class Admin::UsersController < Admin::BaseController
  def index

    @users_all = User.all

    @users_all.each do |user|
      user.count_tweets
    end

    @users = @users_all.order(tweets_count: :desc)



  end
end
