class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable
  has_many :products
  has_many :orders
  belongs_to :parent, :class_name => "User", :foreign_key => "parent_user_id"
  has_many :children, :class_name => "User", :foreign_key => "parent_user_id"

  def distributor?
    children.count > 0
  end

  def admin?
    id == 1
  end
end
