module ApplicationHelper

  def user_avatar(user)
    if user.avatar?
      user.avatar
    else
      "https://goo.gl/smhDDf"
    end
  end

end
