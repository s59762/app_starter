class AddOptionValueIdsToProductVariants < ActiveRecord::Migration[5.2]
  def change
    add_column :product_variants, :option_value_ids, :jsonb, default: []
  end
end
