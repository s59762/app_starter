class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.references :category, foreign_key: { to_table: :product_categories }, index: true
      t.integer :cover
      t.monetize :original_price, default: 0
      t.monetize :sell_price, default: 0
      t.monetize :discounted_price, default: 0
      t.boolean :is_preorder, default: false
      t.jsonb :properties, default: []

      t.timestamps
    end
  end
end
