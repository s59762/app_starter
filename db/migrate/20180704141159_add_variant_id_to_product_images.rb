class AddVariantIdToProductImages < ActiveRecord::Migration[5.2]
  def change
    add_reference :product_images, :variant, foreign_key: { to_table: :product_variants }, index: true
  end
end
