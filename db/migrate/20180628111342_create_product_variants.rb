class CreateProductVariants < ActiveRecord::Migration[5.2]
  def change
    create_table :product_variants do |t|
      t.string :name
      t.string :sku
      t.monetize :original_price, default: 0
      t.monetize :sell_price, default: 0
      t.monetize :discounted_price, default: 0
      t.decimal :weight
      t.decimal :width
      t.decimal :depth
      t.decimal :height
      t.boolean :is_master, default: false
      t.text :description
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
