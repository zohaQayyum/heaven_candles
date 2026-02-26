class CreateOrders < ActiveRecord::Migration[7.1]
  def up
    create_table :orders do |t|
      t.references :user, foreign_key: true, null: true
      t.string :order_number, null: false

      t.integer :status, null: false, default: 0

      t.integer :total_amount, null: false, default: 0

      t.string :shipping_name, null: false
      t.text   :shipping_address, null: false
      t.string :shipping_city, null: false
      t.string :shipping_phone, null: false

      t.integer :payment_status, null: false, default: 0
      t.string  :payment_reference

      t.timestamps
    end

    add_index :orders, :order_number, unique: true
  end

  def down
    remove_index :orders, :order_number
    drop_table :orders
  end
end
