class CreateProductVariants < ActiveRecord::Migration[7.1]
  def up
    create_table :product_variants do |t|
      t.references :product, null: false, foreign_key: true
      t.string     :size, null: false
      t.decimal    :price, precision: 10, scale: 2, null: false
      t.integer    :stock, null: false, default: 0

      t.timestamps
    end

    add_index :product_variants, [:product_id, :size], unique: true
  end

  def down
    remove_index :product_variants, column: [:product_id, :size]
    drop_table :product_variants
  end
end
