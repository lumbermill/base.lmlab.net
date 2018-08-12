class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_paper_trail

  scope :in_cart, -> { where(status: "in-cart") }
  scope :ordered, -> { where(status: "ordered") }
  scope :shipping, -> { where(status: "shipping") }
  scope :arrived, -> { where(status: "arrived") }
  scope :canceled, -> { where(status: "canceled") }
end
