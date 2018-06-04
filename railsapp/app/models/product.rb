class Product < ApplicationRecord
  belongs_to :user
  has_paper_trail
end
