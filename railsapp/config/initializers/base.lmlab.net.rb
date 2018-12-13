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
  },
  pcn: {name: "PCN", url: "https://hello002.stores.jp/",
    url4product: "https://hello002.stores.jp/items/{code}"
  }}

MAKERS = makers

# Set your secret key: remember to change this to your live secret key in production
# See your keys here: https://dashboard.stripe.com/account/apikeys
Stripe.api_key = "sk_test_YT7FJcajRolhIx7uFewYzCfa"
