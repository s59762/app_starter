class AddNormalSpecsToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :width, :decimal
    add_column :products, :depth, :decimal
    add_column :products, :height, :decimal
    add_column :products, :weight, :decimal
  end
end
