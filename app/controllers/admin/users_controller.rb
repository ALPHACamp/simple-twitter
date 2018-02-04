class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(created_at: :asc).page(params[:page]).per(10)

    users = User.order(created_at: :asc)

    be_liked_count = []

    users.each do |user|
      num = 0

      user.tweets.each do |tweet|
        num += tweet.likes_count
      end
      
      be_liked_count << num
    end

    @be_liked_count = be_liked_count

  end
end
