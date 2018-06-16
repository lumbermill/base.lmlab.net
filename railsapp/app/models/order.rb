class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_paper_trail

  scope :in_cart, -> { where(status: "in-cart") }
end
