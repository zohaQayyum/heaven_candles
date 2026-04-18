class ChangeProductVariantPriceToInteger < ActiveRecord::Migration[7.1]
  def up
    change_column :product_variants, :price, :integer
  end

  def down
    change_column :product_variants, :price, :decimal
  end
end
