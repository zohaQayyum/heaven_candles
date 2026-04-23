class CreateReviews < ActiveRecord::Migration[7.1]
  def up
    create_table :reviews do |t|
      t.references :product, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true
      t.integer :rating
      t.text :comment
      t.string :guest_name
      t.string :guest_email
      t.integer :status, default: 0, null: false

      t.timestamps
    end

    add_index :reviews, [:user_id, :product_id], unique: true
  end

  def down
    remove_index :reviews, [:user_id, :product_id]
    drop_table :reviews
  end
end
