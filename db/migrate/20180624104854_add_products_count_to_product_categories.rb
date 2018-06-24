class AddProductsCountToProductCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :product_categories, :products_count, :integer, default: 0

    ProductCategory.pluck(:id).each do |id|
      ProductCategory.reset_counters(id, :products)
    end
  end
end
