class CreateCategories < ActiveRecord::Migration[7.1]
  def up
    create_table :categories do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :categories, :name, unique: true
  end

  def down
    remove_index :categories, :name
    drop_table :categories
  end
end
