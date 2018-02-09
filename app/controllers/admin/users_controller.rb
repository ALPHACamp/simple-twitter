class Admin::UsersController < Admin::BaseController
  def index
    @users = User.left_joins(:tweets).group(:id).order('COUNT(tweets.id) DESC', created_at: :desc).page(params[:page]).per(10)

    users =  User.left_joins(:tweets).group(:id).order('COUNT(tweets.id) DESC', created_at: :desc)

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
