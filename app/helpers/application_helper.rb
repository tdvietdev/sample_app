module ApplicationHelper
  include SessionsHelper

  def full_title page_title = ""
    base_title = t "application.full_title.base_title"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
