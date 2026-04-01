class CreateCartItems < ActiveRecord::Migration[7.1]
  def up
    create_table :cart_items do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :product_variant, null: false, foreign_key: true
      t.integer :quantity
      t.integer :unit_price

      t.timestamps
    end

    add_index :cart_items, [:cart_id, :product_variant_id], unique: true
  end

  def down
    remove_index :cart_items, [:cart_id, :product_variant_id]
    drop_table :cart_items
  end
end
