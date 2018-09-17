class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:root]

  def root
  end

  def dashboard
    @messages = [] # from distributor, from admin
    @tags = Tag.all.order(:code)
    @recents = current_user.recent_products
  end

  def dashboard_count
    key = params[:key]
    # $("#orders_of_children").load("dashboard-count?key=orders_of_children");
    # $("#shipping_of_children").load("dashboard-count?key=shipping_of_children");
    # $("#history_of_children").load("dashboard-count?key=history_of_children");
    # $("#number_of_children").load("dashboard-count?key=number_of_children");
    children = current_user.children.map { |c| c.id }
    case key
    when "orders_of_children" then
      v = Order.ordered.where(user_id: children).count
    when "shipping_of_children" then
      v = Order.shipping.where(user_id: children).count
    when "history_of_children" then
      v = "-" # not implemented
    when "number_of_children" then
      v = current_user.children.count
    else
      v = key
    end
    render plain: v
  end

  def users
    if user_signed_in?
      if current_user.admin?
        @users = User.all
      else
        @users = current_user.children
      end
    else
      render status: 403
    end
  end

  def sign_in_as
    id = params[:id]
    has_priv = false
    if current_user.admin?
      has_priv = true
    elsif current_user.distributor?
      ids = current_user.children.map { |c| c.id }
      has_priv = ids.include? id.to_i
    end
    raise "Only admin or parent can logged in as the user. #{id} #{ids}" unless has_priv
    u = User.find(id)
    sign_in(u)
    redirect_to root_path, notice: "Signed in as: #{u.name}(id:#{u.id})"
  end
end
