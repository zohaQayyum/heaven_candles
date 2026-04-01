class CreateCarts < ActiveRecord::Migration[7.1]
  def up
    create_table :carts do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end

  def down
    drop_table :carts
  end
end
