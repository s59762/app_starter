class CreateProductOptionValues < ActiveRecord::Migration[5.2]
  def change
    create_table :product_option_values do |t|
      t.string :value
      t.references :option_type, foreign_key: { to_table: :product_option_types }, index: true

      t.timestamps
    end
  end
end
