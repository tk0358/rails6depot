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

  def calculate_locale_price(locale, price)
    if locale == :en
      return price
    elsif locale == :es
      return price * 0.9
    elsif locale == :ja
      return (price * 100).to_i
    end
  end
end
