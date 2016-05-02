module ApplicationHelper
  # Returns Full Title on per page basis
  def full_title(page_title = '')
    base_title = "Blog by Tyler Nixon"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
