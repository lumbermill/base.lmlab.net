class Product < ApplicationRecord
  belongs_to :user
  has_many :product_tags
  has_many :tags, through: :product_tags
  has_paper_trail

  def picture_path(suffix="main")
    Product.picture_path(code,suffix)
  end

  def self.picture_realpath(code,suffix="main")
    # ad hoc: how to use picture_id field?
    PRODUCT_IMAGES_DIR+"/#{code}-#{suffix}.jpg"
  end

  def self.picture_path(code,suffix="main")
    "/products/picture?code=#{code}&suffix=#{suffix}"
  end
end
