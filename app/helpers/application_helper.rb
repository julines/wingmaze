module ApplicationHelper
  def title(page_title = nil)
    @page_title ||= page_title
    @page_title.nil? ? "Wingmaze Education - All our tutors achieved a UAT (ATAR) of over 99.  We want our students to do the same!" : "#{@page_title} - Wingmaze Education - All our tutors achieved a UAT (ATAR) of over 99.  We want our students to do the same!"
  end
end
