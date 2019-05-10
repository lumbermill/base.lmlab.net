class Product < ApplicationRecord
  paginates_per 20

  belongs_to :user
  has_many :product_tags
  has_many :tags, through: :product_tags
  has_paper_trail

  validates :code, uniqueness: {scope: :maker}
  validates :name, presence: true
  validates :price, format: { with: /\A[0-9,]+\z/,　message: "半角数字のみが使用できます" }
  validates :cost, format: { with: /\A[0-9,]+\z/,　message: "半角数字のみが使用できます" }

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

  def has_tag?(tag)
    code = (tag.is_a? Tag) ? tag.code : tag
    tags.each do |t|
      return true if t.code == code
    end
    return false
  end

  scope :available, -> { where(status: "available") }
  scope :will_be_available, -> { where(status: "will-be-available") }
  scope :out_of_stock, -> { where(status: "out-of-stock") }
  scope :no_longer_available, -> { where(status: "no-longer-available") }

  # See also ProductHelper.makers
  def self.makers
    Product.select("distinct maker").order("maker").map { |p| p.maker }
  end
end
