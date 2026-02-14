class CreateProducts < ActiveRecord::Migration[7.1]
  def up
    create_table :products do |t|
      t.string     :name, null: false
      t.text       :description
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end

    add_index :products, :name
    add_index :products, :created_at
  end

  def down
    remove_index :products, :name
    remove_index :products, :created_at
    drop_table :products
  end
end
