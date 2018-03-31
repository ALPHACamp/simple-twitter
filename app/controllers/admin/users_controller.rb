class Admin::UsersController < Admin::BaseController
before_action :count_tweets, only: [:index]

  def index
    #@userall = User.all
    #@userall.each do |user|
    #  user.tweets_count = user.tweets.count
    #  user.save!
    #end
    @users = User.order(tweets_count: :desc)
  end

  private

    def count_tweets
      userall = User.all
      userall.each do |user|
        user.tweets_count = user.tweets.count
        user.save!
      end
    end  
end
