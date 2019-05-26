class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!


  # GET /orders
  # GET /orders.json
  def index
    ts = params[:checkout_at]
    if ts.nil?
      @checkout_at = nil
      @orders = current_user.orders.in_cart
      @removable = true
    else
      u = User.find(params[:user_id]) if params[:user_id]
      u = current_user unless u
      @checkout_at = Time.parse(ts)
      @orders = u.orders.where(checkout_at: @checkout_at)
    end
  end

  def index_of_children
    status = params[:status]
    # 自分の子どものordersでstatusがorderedの商品(商品ごと)
    # 自分の子どものordersでstatusがshippingの商品(ユーザごと)
    @checkout_at = nil
    children = current_user.users4order
    if status == "ordered"
      @title = "orders_of_children"
      @orders = Order.ordered.where(user_id: children.map { |c| c.id })
      if @orders.count == 0
        @orders = nil
      elsif params[:group_by_product]
        @orders = @orders.group(:product_id).select("product_id, sum(quantity) as quantity")
      end
    elsif status == "shipping"
      @title = "shipping_of_children"
      @orders = Order.shipping.where(user_id: children.map { |c| c.id })
      if @orders.count == 0
        @orders = nil
      elsif params[:group_by_product]
        @orders = @orders.group(:product_id).select("product_id, sum(quantity) as quantity")
      end
    end
    respond_to do |format|
      format.html
      format.csv
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id if @order.user_id == 0
    @order.price = @order.product.price
    another_order = current_user.orders.in_cart.where(product_id: @order.product_id).first
    logger.debug("----------------#{@order.price}..........")
    if another_order
      another_order.quantity += @order.quantity
      another_order.price += (@order.quantity*@order.price)
      logger.debug("----------------#{@order.price}..........")
      @order = another_order
    end
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: t('Order was successfully created') }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: t('Order was successfully updated') }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    if @order.status == "in-cart"
      @order.destroy
      m = 'Order was successfully destroyed'
    else
      m = 'can not destoy'
    end
    respond_to do |format|
      format.html { redirect_to orders_url, notice: t(m) }
      format.json { head :no_content }
    end
  end

  def checkout1
    @orders = current_user.orders.in_cart
    @use_stripe = current_user.parent&.admin?
  end

  def checkout2
    u = current_user
    orders = u.orders.in_cart
    ts = Time.now
    @n_items = 0
    orders.each do |o|
      @n_items += o.quantity
      o.checkout_at = ts
      o.status = "ordered"
      o.save
    end
    @checkout_at = ts
    @total = Order.total(orders)
    stripe(@total) if params[:stripeToken]
    SlackJob.perform_now("#{u.name}様(id:#{u.id})の注文が確定されました。\n#{ts}, #{@n_items}\nhttps://base.lmlab.net")
    Mailer.simple(nil,u.email,'注文確定','注文が確定されました。').deliver
    # TODO: Need some more info for the customer.
  end

  def history
    if params[:children]
      @title = "history_of_children"
      @orders = current_user.checkout_histories_of_children
    else
      @title = "history"
      @orders = current_user.checkout_histories
    end
  end

  def n_in_cart
    render plain: "#{current_user.orders.in_cart.count}"
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:user_id, :checkout_at, :product_id, :quantity, :status, :price)
  end

  def stripe(total)
    # Token is created using Checkout or Elements!
    # Get the payment token ID submitted by the form:
    token = params[:stripeToken]

    charge = Stripe::Charge.create({
        amount: total,
        currency: 'jpy',
        description: 'Example charge',
        source: token,
    })
  end
end
