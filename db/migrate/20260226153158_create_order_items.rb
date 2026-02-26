class CreateOrderItems < ActiveRecord::Migration[7.1]
  def up
    create_table :order_items do |t|
      t.references :order, foreign_key: true, null: false
      t.references :product_variant, foreign_key: true, null: false

      t.string :sku, null: false
      t.string :product_name, null: false
      t.string :size, null: false

      t.integer :quantity, null: false, default: 1
      t.integer :unit_price, null: false, default: 0
      t.integer :total_price, null: false, default: 0

      t.timestamps
    end
  end


  def down
    drop_table :order_items
  end
end
