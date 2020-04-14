module ApplicationHelper

  def render_if(condition, record)
    if condition
      render record
    end
  end

  def locale_detail(code)
    LANGUAGES.each do |language|
      if language[1] == code
        return language[0]
      end
    end
  end
end
