class CreateCouponUsages < ActiveRecord::Migration[7.1]
  def up
    create_table :coupon_usages do |t|
      t.references :coupon, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true
      t.string :session_id

      t.timestamps
    end
  end

  def down
    drop_table :coupon_usages
  end
end
