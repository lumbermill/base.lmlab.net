class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable
  has_many :products
  has_many :orders
  # belongs_to :parent, :class_name => "User", :foreign_key => "parent_user_id"
  belongs_to :parent, :class_name => "User", optional: true
  has_many :children, :class_name => "User", :foreign_key => "parent_id"
  # has_many :children, :class_name => "User", :foreign_key => "parent_id"

  def distributor?
    children.count > 0
  end

  def admin?
    id == 1
  end

  def recent_products
    ids = orders.select("product_id").order("updated_at desc").map { |o| o.product_id }.uniq[0,4]
    ids.map { |id| Product.find(id) }
  end

  def checkout_histories
    orders.select("checkout_at,sum(quantity) as quantity,sum(price) as price,status")
      .group(:checkout_at,:status).having("checkout_at is not null")
      .order("checkout_at desc")
  end
end
