class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]

  # GET /products
  # GET /products.json
  def index
    @keyword = params[:search]
    # Use previous keyword.
    if @keyword.nil?
      @keyword = session[:search]
    else
      session[:search] = @keyword
    end

    if @keyword.blank?
      @products = Product.all
    elsif @keyword.start_with? "tag:"
      tag = @keyword.sub("tag:","").strip
      @products = Tag.where(code:tag).first.products
    elsif @keyword.to_i == 0
      @products = Product.where("name like ? or size like ?", "%"+@keyword+"%", "%"+@keyword+"%")
    else
      @products = Product.where(code: @keyword.to_i)
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: t('Product') + t('was successfully created') }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: t('Product') + t('was successfully updated') }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: t('Product') + t('was successfully destroyed') }
      format.json { head :no_content }
    end
  end

  def picture
    code = params[:code]
    f = Product.picture_realpath(code)
    if File.file? f
      send_file(f, type: 'image/jpeg', disposition: "inline")
    else
      head 404
      send_file(Rails.root.join('app', 'assets', 'images', 'no-photo.png'), type: 'image/jpeg', disposition: "inline", status: 404)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:user_id, :code, :maker, :name, :size, :price, :cost, :picture_id, :copy, :memo)
    end
end
