class CreateProductCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :product_categories do |t|
      t.string :name
      t.string :description
      t.references :parent, foreign_key: { to_table: :product_categories }, index: true

      t.timestamps
    end
  end
end
