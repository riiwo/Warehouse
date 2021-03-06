class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_worker

  # GET /products
  def index
    @products = Product.all
  end

  # GET /products/1
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
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /products/1
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
    end
  end

  def get_groups
    product = Product::where(:id => params[:product_ID]).first
    @groups = product.groups
    respond_to do |format|
      format.json { render json: @groups }
    end
  end
  def get_all_other_groups
    product = Product::where(:id => params[:product_ID]).first
    ids = product.groups.select(:id)
    @groups = Group.where.not(id:  ids);
    respond_to do |format|
      format.json { render json: @groups }
    end
  end
  def add_group
    product = Product::where(:id => params[:product_ID]).first
    group = Group::where(:id => params[:group_ID]).first
    product.groups << group unless product.groups.include?(group)
    product.save
    respond_to do |format|
      format.json { render json: '{}' }
    end
  end
  def remove_group
    product = Product::where(:id => params[:product_ID]).first
    @group = Group::where(:id => params[:group_ID]).first
    product.groups.delete(@group)
    product.save
    respond_to do |format|
      format.json { render json: @group }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.fetch(:product, {}).permit(:name, :description, :img, :price)
    end
end
