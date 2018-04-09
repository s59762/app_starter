class CreateProductImages < ActiveRecord::Migration[5.1]
  def change
    create_table :product_images do |t|
      t.string :image
      t.integer :use_case, default: 0
      t.string :original_filename
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
