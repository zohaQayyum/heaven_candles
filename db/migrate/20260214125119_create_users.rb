class CreateUsers < ActiveRecord::Migration[7.1]
  def up
    create_table :users do |t|
      t.string  :name, null: false
      t.string  :email, null: false
      t.string  :password_digest, null: false
      t.integer :role, null: false, default: 0

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :role
  end

  def down
    remove_index :users, :email
    remove_index :users, :role
    drop_table :users
  end
end
