class Admin::ProductsController < Admin::ApplicationController
  before_action :set_product, only:%i[edit update destroy remove_image]

  def index
    @products = Product.includes(:category).all
  end

  def new
    @product = Product.new
    @categories = Category.all 
  end

  def create
    @product = Product.new(product_params.except(:images))
    if @product.save
      @product.images.attach(params[:product][:images]) if params[:product][:images].present?
      redirect_to admin_products_path, notice: 'Product was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @categories = Category.all 
  end

  def update
    if @product.update(product_params.except(:images))
      @product.images.attach(params[:product][:images]) if params[:product][:images].present?
      redirect_to admin_products_path, notice: 'Product was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def remove_image
    image = ActiveStorage::Attachment.find(params[:image_id])
    image.purge
    redirect_to edit_admin_product_path(@product), notice: 'Image removed successfully.'
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: 'Product was successfully deleted.'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :category_id,
      images: []
    )
  end
end
