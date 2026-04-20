class CreateCoupons < ActiveRecord::Migration[7.1]
  def up
    create_table :coupons do |t|
      t.string :code
      t.integer :discount_type
      t.decimal :discount_value
      t.datetime :expires_at
      t.boolean :active, default: false

      t.timestamps
    end
    add_index :coupons, :code, unique: true
  end

  def down
    drop_table :coupons
  end
end
