class AddSkuToProductVariants < ActiveRecord::Migration[7.1]
   def up
    add_column :product_variants, :sku, :string, null: false
    
    add_index :product_variants, :sku, unique: true
  end

  def down
    remove_index :product_variants, :sku
    remove_column :product_variants, :sku
  end
end
