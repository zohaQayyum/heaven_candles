class Admin::ProductVariantsController < Admin::ApplicationController
  before_action :set_product
  before_action :set_product_variant, only: %i[edit update destroy]

  def index
    @variants = @product.product_variants
  end

  def new
    @product_variant = @product.product_variants.build
  end

  def create
    @product_variant = @product.product_variants.build(product_variant_params)

    if @product_variant.save
      redirect_to admin_product_variants_path(@product), notice: 'Product Variant was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product_variant.update(product_variant_params)
      redirect_to admin_product_variants_path(@product), notice: 'Product Variant was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product_variant.destroy
    redirect_to admin_product_variants_path(@product), notice: 'Product Variant was successfully deleted.'
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_product_variant
    @product_variant = @product.product_variants.find(params[:id])
  end

  def product_variant_params
    params.require(:product_variant).permit(:size, :price, :stock, :sku)
  end
end
