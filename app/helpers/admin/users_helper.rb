module Admin::UsersHelper

  def sortable(column, title = nil)
    title ||= column

    # if not sorting this column, just return a link without icon
    if column != current_title
      return link_to(column, :sort => column, :direction => 'desc')
    end

    # if sorting this column, find out it's direction and show correspond icon
    if sort_direction == 'desc'
      direction = 'asc'
      icon_direction = '-alt'
    else
      direction = 'desc'
      icon_direction = ''
    end
    link_to("#{column}<span class='glyphicon glyphicon-sort-by-attributes#{icon_direction}'></span>".html_safe, :sort => column, :direction => direction)

  end

end
