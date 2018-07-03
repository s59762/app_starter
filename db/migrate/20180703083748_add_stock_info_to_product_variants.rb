class AddStockInfoToProductVariants < ActiveRecord::Migration[5.2]
  def change
    add_column :product_variants, :stock, :integer, default: 0
    add_column :products, :total_stock, :integer, default: 0
  end
end
