class AddIsCoverToProductImages < ActiveRecord::Migration[5.2]
  def change
    add_column :product_images, :is_cover, :boolean, default: false
  end
end
