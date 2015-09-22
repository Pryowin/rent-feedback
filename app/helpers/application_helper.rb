module ApplicationHelper

  def complete_title(page_title = '')
    base_title = RentFeedback::Application::APP_NAME
    if page_title.empty?
      return base_title
    else
      return "#{page_title} | #{base_title}"
    end
  end
end
