class Admin::UsersController < Admin::BaseController

  def index

    # ---------------------- #
    #@users = User.joins('LEFT JOIN tweets ON tweets.user_id = users.id')
    #.group('tweets.user_id')
    #.order('COUNT(tweets.user_id) DESC')

    # ---------------------- #
    #@users = Array.new

    #@some_users= User.joins('INNER JOIN tweets ON tweets.user_id = users.id')
    #.group('tweets.user_id')
    #.order('COUNT(tweets.user_id) DESC')


    #@some_users.each do |user|
    #  @users.push(user)
    #end

    #tmp_user = User.all
    #tmp_user.each do |user|
    #  if user.tweets.count == 0
    #    @users.push(user)
    #  end
    #end
    # ---------------------- #

    @users = User.all
  end

end
