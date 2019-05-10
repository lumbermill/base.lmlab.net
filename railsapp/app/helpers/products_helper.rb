module ProductsHelper
  def makers
    MAKERS.keys.join(", ")
  end

  def makers_url(product)
    html = ""
    MAKERS.keys.each do |m|
      maker = MAKERS[m]
      if product.code
        url = maker[:url4product].gsub("{code}",product.code.to_s)
      else
        url = maker[:url]
      end
      name = maker[:name]
      if product.maker == m.to_s
        # FIXME: i18n
        html += "<a href='#{url}' target='#{m}'>#{name} で検索</a> "
      end
    end
    return html
  end

  def makers_link(product)
    return "" if product.maker.blank?
    m = product.maker
    "<a href='/products?search=maker:#{m}'>#{m}</a><br/>"
  end

  def makers_as_list(include_empty: true)
    html = "<a href='/products?search=maker:'>undefined</a><br/>"
    MAKERS.keys.each do |m|
      html += "<a href='/products?search=maker:#{m}'>#{m}</a><br/>"
    end
    html.html_safe
  end

  def tags_as_labels(product)
    return "" if product.tags.count == 0
    html = product.tags.map do |v|
      "<a href='/products/?search=tag:#{v.code}'><span class='label label-default' title='#{v.code}'>#{v.name}</span></a>"
    end.join(" ")
    return html.html_safe
  end
end
