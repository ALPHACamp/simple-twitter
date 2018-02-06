module UsersHelper
  def user_avatar(img, classes)
    if image_path(img) == ''
      return image_tag('http://via.placeholder.com/300x300', class: classes)
    else
      return image_tag(img, class: classes)
    end
  end
end
