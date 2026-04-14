class AddShippingEmailToOrders < ActiveRecord::Migration[7.1]
  def up
    add_column :orders, :shipping_email, :string
  end

  def down
    remove_column :orders, :shipping_email
  end
end
