class ChangeSizeToIntegerInProductVariants < ActiveRecord::Migration[7.1]
  def up
    change_column :product_variants, :size, :integer,
      using: "CASE size
                WHEN 'small' THEN 0
                WHEN 'large' THEN 1
              END"
  end

  def down
    change_column :product_variants, :size, :string,
      using: "CASE size
                WHEN 0 THEN 'small'
                WHEN 1 THEN 'large'
              END"
  end
end
