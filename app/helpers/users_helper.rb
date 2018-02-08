module UsersHelper
  def user_avatar(img, classes)
    if img == '' || img == nil
      return image_tag('http://via.placeholder.com/300x300', class: classes)
    else
      return image_tag(img.html_safe, class: classes)
      return img
    end
  end
end
