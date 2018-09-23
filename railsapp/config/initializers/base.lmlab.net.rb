PRODUCT_IMAGES_DIR = "/var/www/base/uploads/products"
TAG_IMAGES_DIR = "/var/www/base/uploads/tags"

I18n.available_locales = [:en, :ja]
I18n.default_locale = :ja
# I18n.locale = :ja  does not work here
# Rails.application.config.time_zone = 'Tokyo'  does not work here. See application.rb

# They are like suppliers.
makers = {
  amway: {name: "Amway", url: "https://amwaylive.com",
    url4product: "https://www1.amwaylive.com/search/Search?keyword={code}"
  },
  ksy: {name: "KSY", url: "https://raspberry-pi.ksyic.com/",
    url4product: "https://raspberry-pi.ksyic.com/main/index/pdp.id/{code}/pdp.open/{code}"
  }}

MAKERS = makers
