module Admin::UsersHelper

  def sortable(column, title = nil)
    title ||= column
    if column == current_title && sort_direction == 'desc'
      direction = 'asc'
      icon_direction = '-alt'
    else
      direction = 'desc'
      icon_direction = ''
    end

    if column == current_title
      link_to("#{column}<span class='glyphicon glyphicon-sort-by-attributes#{icon_direction}'></span>".html_safe, :sort => column, :direction => direction)
    else
      link_to(column, :sort => column, :direction => direction)
    end
  end

end
