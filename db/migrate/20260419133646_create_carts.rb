class CreateCarts < ActiveRecord::Migration[7.1]
  def up
    create_table :carts do |t|
      t.references :user, null: true, foreign_key: true
      t.string :session_id

      t.timestamps
    end
  end

  def down
    drop_table :carts
  end
end
