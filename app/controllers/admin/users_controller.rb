class Admin::UsersController < Admin::BaseController

  def index
    #@users = User.all

    #@users = User.select("COUNT(*) AS count_all, tweets.user_id AS tweets_user_id")
    #.joins('LEFT JOIN tweets ON tweets.user_id = users.id')
    #.group('tweets.user_id')
    #.order('COUNT(tweets.user_id) DESC')

    #@users = User.joins('LEFT JOIN tweets ON tweets.user_id = users.id')
    #.group('tweets.user_id')
    #.order('COUNT(tweets.user_id) DESC')
    puts "~~~~~~~~~~~~1"
    @users = Array.new
    puts "~~~~~~~~~~~~2"
    @some_users= User.joins('INNER JOIN tweets ON tweets.user_id = users.id')
    .group('tweets.user_id')
    .order('COUNT(tweets.user_id) DESC')

    puts "~~~~~~~~~~~~3"
    @some_users.each do |user|
      @users.push(user)
    end
    puts "~~~~~~~~~~~~4"
    tmp_user = User.all
    tmp_user.each do |user|
      if user.tweets.count == 0
        @users.push(user)
      end
    end
  end

end
