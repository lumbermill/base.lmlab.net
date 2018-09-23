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
end
