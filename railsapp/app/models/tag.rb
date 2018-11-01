class Tag < ApplicationRecord
  has_many :product_tags
  has_many :products, through: :product_tags

  validates :code, uniqueness: true
  validates :name, presence: true

  def picture_path
    Tag.picture_path(code)
  end

  def self.picture_realpath(code)
    TAG_IMAGES_DIR+"/#{code}.jpg"
  end

  def self.picture_path(code)
    "/tags/picture?code=#{code}"
  end
end
