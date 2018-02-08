class Admin::UsersController < Admin::BaseController
  helper_method :sort_column, :sort_direction, :current_title

  def index
    # @users = User.all.order('tweets_count desc')
    @users = User.all.order(sort_column + " " + sort_direction)
    @current_title = current_title
  end


  private

  def sort_column
    case params[:sort]
      when 'Name'
        'name'

      when 'Tweets'
        'tweets_count'

      when 'Followings'
        'followings_count'

      when 'Followers'
        'followers_count'

      when 'Got likes'
        'got_likes_count'

      else
        'tweets_count'

    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def current_title
    %w[Name Tweets Followings Followers Got likes].include?(params[:sort]) ? params[:sort] : 'Tweets'
  end
end
