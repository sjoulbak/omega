module ApplicationHelper
  # This method will return a link path with the id 'active' or nothing if the link_path isn't the same as the current page
  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'active' : ''
    content_tag(:li, :id => class_name) do
      link_to link_text, link_path
    end
  end
end
