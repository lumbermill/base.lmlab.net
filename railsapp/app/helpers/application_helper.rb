module ApplicationHelper
  def sanitize_message(text)
    return "" if text.blank?
    html = text.gsub(/\n/,"<br/>")
    sanitize(html, tags:%w(br b i a span), attributes: %w(href class)).html_safe
  end
end
