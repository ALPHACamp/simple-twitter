module ApplicationHelper
  def check_avatar
    if current_user.avatar.nil?
      current_user.update(avatar: "https://cdn.filestackcontent.com/z2xAtAcQTF7KgoD67Fpf")
    end
  end
end
