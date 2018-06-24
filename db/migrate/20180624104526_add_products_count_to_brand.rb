class AddProductsCountToBrand < ActiveRecord::Migration[5.2]
  def change
    add_column :brands, :products_count, :integer, default: 0

    Brand.pluck(:id).each do |id|
      Brand.reset_counters(id, :products)
    end
  end
end
